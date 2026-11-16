import 'dart:convert';

import '../../../core/errors/app_exception.dart';
import '../../../shared/models/care_recommendation.dart';
import '../domain/recognition_connection.dart';

class RecognitionPayload {
  const RecognitionPayload({
    required this.title,
    required this.summary,
    required this.confidence,
    required this.recommendations,
    this.plantId,
  });

  final String title;
  final String summary;
  final double confidence;
  final String? plantId;
  final List<CareRecommendation> recommendations;
}

AppException recognitionStatusError(int statusCode) {
  return switch (statusCode) {
    401 ||
    403 => const AppException('Ключ не подошёл. Проверьте его в настройках.'),
    429 => const AppException(
      'Слишком много запросов. Подождите немного и повторите.',
    ),
    400 || 404 || 422 => const AppException(
      'Сервис не принял запрос. Проверьте модель, каталог или адрес сервера.',
    ),
    _ => const AppException(
      'Сервис распознавания ответил ошибкой. Попробуйте другое фото.',
    ),
  };
}

RecognitionPayload parseRecognitionBody({
  required RecognitionBackend backend,
  required String body,
}) {
  final decoded = _decodeObject(body);
  if (backend == RecognitionBackend.yandex) {
    return parseRecognitionPayload(
      _decodeObject(extractJsonObject(_yandexText(decoded))),
    );
  }
  return parseRecognitionPayload(decoded);
}

RecognitionPayload parseRecognitionPayload(Map<String, dynamic> json) {
  final recommendations = _recommendations(json['recommendations']);
  return RecognitionPayload(
    title: _text(json['title'], fallback: 'Растение на фото'),
    summary: _text(
      json['summary'],
      fallback: 'Сервис не описал фото подробнее. Снимите лист или повреждение крупнее.',
    ),
    confidence: _confidence(json['confidence']),
    plantId: _plantId(json['plantId']),
    recommendations: recommendations.isEmpty
        ? const [
            CareRecommendation(
              title: 'Проверьте ещё раз',
              description: 'Посмотрите лист при дневном свете и сравните его с соседними. Если сомневаетесь, сфотографируйте ближе.',
            ),
          ]
        : recommendations,
  );
}

String extractJsonObject(String text) {
  final fenced = RegExp(r'```(?:json)?\s*([\s\S]*?)```')
      .firstMatch(text)
      ?.group(1);
  final source = (fenced ?? text).trim();
  final start = source.indexOf('{');
  final end = source.lastIndexOf('}');
  if (start < 0 || end <= start) {
    throw const AppException('Сервис вернул ответ не в том формате.');
  }
  return source.substring(start, end + 1);
}

Map<String, dynamic> _decodeObject(String body) {
  try {
    final decoded = jsonDecode(body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    if (decoded is Map) {
      return decoded.map((key, value) => MapEntry(key.toString(), value));
    }
  } on FormatException {
    throw const AppException('Сервис вернул ответ не в том формате.');
  }
  throw const AppException('Сервис вернул ответ не в том формате.');
}

String _yandexText(Map<String, dynamic> json) {
  final choices = json['choices'];
  if (choices is! List || choices.isEmpty || choices.first is! Map) {
    throw const AppException('Сервис вернул ответ не в том формате.');
  }
  final message = (choices.first as Map)['message'];
  if (message is! Map) {
    throw const AppException('Сервис вернул ответ не в том формате.');
  }
  final content = message['content'];
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
  throw const AppException('Сервис вернул пустой ответ.');
}

String _text(Object? value, {required String fallback}) {
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
  if (id.isEmpty || id.toLowerCase() == 'null') {
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
  return fraction.clamp(0, 1).toDouble();
}

List<CareRecommendation> _recommendations(Object? value) {
  if (value is! List) {
    return const [];
  }
  return [
    for (final item in value)
      if (item is Map)
        CareRecommendation(
          title: _text(item['title'], fallback: 'Что сделать'),
          description: _text(item['description'], fallback: ''),
          topic: _topic(item['topic']),
        ),
  ].where((item) => item.description.isNotEmpty).toList();
}

CareTopic _topic(Object? value) {
  if (value is! String) {
    return CareTopic.general;
  }
  for (final topic in CareTopic.values) {
    if (topic.name == value.trim()) {
      return topic;
    }
  }
  return CareTopic.general;
}
