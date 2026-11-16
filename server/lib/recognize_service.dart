import 'dart:convert';
import 'dart:typed_data';

import 'plants.dart';
import 'server_config.dart';

class YandexCall {
  const YandexCall({
    required this.uri,
    required this.apiKey,
    required this.body,
  });

  final Uri uri;
  final String apiKey;
  final String body;
}

class YandexReply {
  const YandexReply(this.statusCode, this.body);

  final int statusCode;
  final String body;
}

typedef YandexCaller = Future<YandexReply> Function(YandexCall call);

class RecognitionHttpResult {
  const RecognitionHttpResult(this.statusCode, this.json);

  final int statusCode;
  final Map<String, Object?> json;
}

class RecognizeService {
  RecognizeService({
    required this.config,
    required this.callYandex,
    SlidingWindowLimiter? limiter,
  }) : limiter =
           limiter ??
           SlidingWindowLimiter(
             limit: config.rateLimit,
             window: config.rateWindow,
           );

  final ServerConfig config;
  final YandexCaller callYandex;
  final SlidingWindowLimiter limiter;

  Future<RecognitionHttpResult> recognize({
    required String? authorization,
    required String body,
    required String remoteAddress,
    DateTime? now,
  }) async {
    if (!_authorized(authorization)) {
      return const RecognitionHttpResult(401, {
        'error': 'Ключ доступа не подошёл.',
      });
    }
    if (!limiter.allow(remoteAddress, now ?? DateTime.now())) {
      return const RecognitionHttpResult(429, {
        'error': 'Слишком много запросов. Подождите немного.',
      });
    }

    final incoming = _readIncoming(body);
    if (incoming is RecognitionHttpResult) {
      return incoming;
    }
    final photo = incoming as _IncomingPhoto;

    final YandexReply reply;
    try {
      reply = await callYandex(
        YandexCall(
          uri: Uri.parse(config.yandexUri),
          apiKey: config.yandexApiKey,
          body: jsonEncode(_yandexBody(photo)),
        ),
      );
    } catch (_) {
      return const RecognitionHttpResult(502, {
        'error': 'Сервис распознавания временно недоступен.',
      });
    }
    if (reply.statusCode == 429) {
      return const RecognitionHttpResult(429, {
        'error': 'Слишком много запросов. Подождите немного.',
      });
    }
    if (reply.statusCode < 200 || reply.statusCode >= 300) {
      return const RecognitionHttpResult(502, {
        'error': 'Сервис распознавания временно недоступен.',
      });
    }
    try {
      return RecognitionHttpResult(200, _payloadFromYandex(reply.body));
    } on FormatException {
      return const RecognitionHttpResult(502, {
        'error': 'Сервис распознавания временно недоступен.',
      });
    }
  }

  bool _authorized(String? authorization) {
    final header = authorization?.trim() ?? '';
    final separator = header.indexOf(' ');
    if (separator <= 0) {
      return false;
    }
    final scheme = header.substring(0, separator);
    final token = header.substring(separator + 1).trim();
    return scheme.toLowerCase() == 'bearer' &&
        _sameSecret(token, config.clientApiKey);
  }

  Object _readIncoming(String body) {
    final Object? decoded;
    try {
      decoded = jsonDecode(body);
    } on FormatException {
      return const RecognitionHttpResult(400, {'error': 'Нужен JSON с фото.'});
    }
    if (decoded is! Map) {
      return const RecognitionHttpResult(400, {'error': 'Нужен JSON с фото.'});
    }
    final imageBase64 = decoded['imageBase64'];
    final mimeType = _mime(decoded['mimeType']);
    if (imageBase64 is! String ||
        imageBase64.trim().isEmpty ||
        mimeType == null) {
      return const RecognitionHttpResult(400, {
        'error': 'Нужны поля imageBase64 и mimeType.',
      });
    }
    if (imageBase64.length > config.maxImageBytes * 2) {
      return const RecognitionHttpResult(400, {
        'error': 'Фото слишком большое.',
      });
    }
    final Uint8List bytes;
    try {
      bytes = base64Decode(imageBase64);
    } on FormatException {
      return const RecognitionHttpResult(400, {
        'error': 'Фото передано не целиком.',
      });
    }
    if (bytes.isEmpty || bytes.length > config.maxImageBytes) {
      return const RecognitionHttpResult(400, {
        'error': 'Фото слишком большое.',
      });
    }
    return _IncomingPhoto(imageBase64, mimeType);
  }

  Map<String, Object?> _yandexBody(_IncomingPhoto photo) {
    final catalog = plantCatalog.entries
        .map((plant) => '${plant.key} — ${plant.value}')
        .join('\n');
    return {
      'model': config.modelUri,
      'temperature': 0.2,
      'max_tokens': 1200,
      'messages': [
        {
          'role': 'system',
          'content':
              'Ты помогаешь людям без специального образования ухаживать за растениями в России. '
              'По фото определи растение и видимую проблему. Ответь только JSON без пояснений:\n'
              '{"title":"короткое название","summary":"2-3 простых предложения","confidence":0.0,'
              '"plantId":"id или null","recommendations":[{"title":"...","description":"...","topic":"watering|light|temperature|feeding|pruning|planting|general"}]}\n'
              'plantId только из списка ниже или null. Не указывай точные дозы химикатов. '
              'Если фото неясное, напиши об этом в summary и поставь низкую confidence. '
              'Это подсказка, не лабораторный диагноз.\n'
              'Список растений:\n$catalog',
        },
        {
          'role': 'user',
          'content': [
            {'type': 'text', 'text': 'Что на фото и что сделать дальше?'},
            {
              'type': 'image_url',
              'image_url': {
                'url': 'data:${photo.mimeType};base64,${photo.imageBase64}',
              },
            },
          ],
        },
      ],
    };
  }

  Map<String, Object?> _payloadFromYandex(String body) {
    final decoded = jsonDecode(body);
    if (decoded is! Map) {
      throw const FormatException('Ответ не объект');
    }
    final choices = decoded['choices'];
    if (choices is! List || choices.isEmpty || choices.first is! Map) {
      throw const FormatException('Нет choices');
    }
    final message = (choices.first as Map)['message'];
    if (message is! Map) {
      throw const FormatException('Нет message');
    }
    final text = _messageText(message['content']);
    final payload = jsonDecode(_jsonObject(text));
    if (payload is! Map) {
      throw const FormatException('Полезная нагрузка не объект');
    }
    final recommendations = _recommendations(payload['recommendations']);
    final plantId = _plantId(payload['plantId']);
    return {
      'title': _text(payload['title'], 'Растение на фото'),
      'summary': _text(
        payload['summary'],
        'Сервис не описал фото подробнее. Снимите лист или повреждение крупнее.',
      ),
      'confidence': _confidence(payload['confidence']),
      'plantId': plantId,
      'recommendations': recommendations.isEmpty
          ? [
              {
                'title': 'Проверьте ещё раз',
                'description': 'Посмотрите лист при дневном свете и сравните его с соседними. Если сомневаетесь, сфотографируйте ближе.',
                'topic': 'general',
              },
            ]
          : recommendations,
    };
  }
}

class SlidingWindowLimiter {
  SlidingWindowLimiter({required this.limit, required this.window});

  final int limit;
  final Duration window;
  final Map<String, List<DateTime>> _hits = {};

  bool allow(String key, DateTime now) {
    final hits = _hits.putIfAbsent(key, () => []);
    hits.removeWhere((time) => now.difference(time) >= window);
    if (hits.length >= limit) {
      return false;
    }
    hits.add(now);
    return true;
  }
}

class _IncomingPhoto {
  const _IncomingPhoto(this.imageBase64, this.mimeType);

  final String imageBase64;
  final String mimeType;
}

const _topics = {
  'watering',
  'light',
  'temperature',
  'feeding',
  'pruning',
  'planting',
  'general',
};

String? _mime(Object? value) {
  if (value is! String) {
    return null;
  }
  final mime = value.split(';').first.trim().toLowerCase();
  return switch (mime) {
    'image/jpg' || 'image/jpeg' => 'image/jpeg',
    'image/png' => 'image/png',
    'image/webp' => 'image/webp',
    _ => null,
  };
}

String _messageText(Object? content) {
  if (content is String && content.trim().isNotEmpty) {
    return content;
  }
  if (content is List) {
    final text = content
        .whereType<Map>()
        .map((part) => part['text'])
        .whereType<String>()
        .join('\n')
        .trim();
    if (text.isNotEmpty) {
      return text;
    }
  }
  throw const FormatException('Пустой ответ');
}

String _jsonObject(String text) {
  final fenced = RegExp(r'```(?:json)?\s*([\s\S]*?)```')
      .firstMatch(text)
      ?.group(1);
  final source = (fenced ?? text).trim();
  final start = source.indexOf('{');
  final end = source.lastIndexOf('}');
  if (start < 0 || end <= start) {
    throw const FormatException('В ответе нет JSON');
  }
  return source.substring(start, end + 1);
}

String _text(Object? value, String fallback) {
  if (value is String && value.trim().isNotEmpty) {
    return value.trim();
  }
  return fallback;
}

String? _plantId(Object? value) {
  if (value is! String) {
    return null;
  }
  final id = value.trim();
  if (!plantCatalog.containsKey(id)) {
    return null;
  }
  return id;
}

double _confidence(Object? value) {
  final number = switch (value) {
    num() => value.toDouble(),
    String() => double.tryParse(value.replaceAll(',', '.')) ?? 0,
    _ => 0.0,
  };
  final fraction = number > 1 ? number / 100 : number;
  if (fraction < 0) {
    return 0;
  }
  if (fraction > 1) {
    return 1;
  }
  return fraction;
}

List<Map<String, String>> _recommendations(Object? value) {
  if (value is! List) {
    return const [];
  }
  return [
    for (final item in value)
      if (item is Map && _text(item['description'], '').isNotEmpty)
        {
          'title': _text(item['title'], 'Что сделать'),
          'description': _text(item['description'], ''),
          'topic': _topics.contains(item['topic'])
              ? item['topic'] as String
              : 'general',
        },
  ];
}

bool _sameSecret(String left, String right) {
  final a = utf8.encode(left);
  final b = utf8.encode(right);
  if (a.length != b.length) {
    return false;
  }
  var diff = 0;
  for (var i = 0; i < a.length; i++) {
    diff |= a[i] ^ b[i];
  }
  return diff == 0;
}
