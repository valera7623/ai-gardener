import 'dart:convert';
import 'dart:io';

import 'package:ai_gardener_server/recognize_server.dart';
import 'package:ai_gardener_server/recognize_service.dart';
import 'package:ai_gardener_server/server_config.dart';
import 'package:test/test.dart';

ServerConfig _config({int rateLimit = 20}) {
  return ServerConfig(
    yandexApiKey: 'yandex-secret',
    clientApiKey: 'client-secret',
    folderId: 'b1gfolder',
    rateLimit: rateLimit,
    rateWindow: const Duration(hours: 1),
  );
}

void main() {
  test('environment keeps the two keys different', () {
    expect(
      () => ServerConfig.fromEnvironment({
        'YANDEX_API_KEY': 'same',
        'CLIENT_API_KEY': 'same',
      }),
      throwsA(isA<ServerConfigException>()),
    );
    final config = ServerConfig.fromEnvironment({
      'YANDEX_API_KEY': 'yandex-secret',
      'CLIENT_API_KEY': 'client-secret',
      'YANDEX_FOLDER_ID': 'b1gfolder',
      'PORT': '9090',
    });
    expect(config.port, 9090);
    expect(config.modelUri, 'gpt://b1gfolder/deepseek-v4.1-flash/latest');
  });

  test('a fenced Yandex answer becomes the app payload', () async {
    final calls = <YandexCall>[];
    final service = RecognizeService(
      config: _config(),
      callYandex: (call) async {
        calls.add(call);
        return YandexReply(
          200,
          jsonEncode({
            'choices': [
              {
                'message': {
                  'content': '```json\n{"title":"Тля на розе","summary":"На бутонах колония.","confidence":80,"plantId":"rose","recommendations":[{"title":"Смыть","description":"Смойте тлю водой.","topic":"general"}]}\n```',
                },
              },
            ],
          }),
        );
      },
    );

    final result = await service.recognize(
      authorization: 'Bearer client-secret',
      body: jsonEncode({
        'imageBase64': base64Encode([1, 2, 3]),
        'mimeType': 'image/jpg',
      }),
      remoteAddress: '10.0.0.8',
    );

    expect(result.statusCode, 200);
    expect(result.json['title'], 'Тля на розе');
    expect(result.json['plantId'], 'rose');
    expect(result.json['confidence'], 0.8);
    final call = calls.single;
    expect(call.apiKey, 'yandex-secret');
    expect(call.uri.toString(), ServerConfig.defaultYandexUri);
    final sent = jsonDecode(call.body) as Map<String, dynamic>;
    expect(sent['model'], 'gpt://b1gfolder/deepseek-v4.1-flash/latest');
    expect(call.body.contains('yandex-secret'), isFalse);
    expect(call.body.contains('client-secret'), isFalse);
    expect(call.body.contains('data:image/jpeg;base64,'), isTrue);
  });

  test('a rejected Yandex key is not sent back to the phone', () async {
    final service = RecognizeService(
      config: _config(),
      callYandex: (call) async =>
          const YandexReply(401, '{"error":"yandex-secret"}'),
    );

    final result = await service.recognize(
      authorization: 'Bearer client-secret',
      body: jsonEncode({
        'imageBase64': base64Encode([1]),
        'mimeType': 'image/png',
      }),
      remoteAddress: '10.0.0.9',
    );

    expect(result.statusCode, 502);
    expect(jsonEncode(result.json).contains('yandex-secret'), isFalse);
  });

  test('the wrong access key does not call Yandex', () async {
    var called = false;
    final service = RecognizeService(
      config: _config(),
      callYandex: (call) async {
        called = true;
        return const YandexReply(200, '{}');
      },
    );

    final result = await service.recognize(
      authorization: 'Bearer wrong',
      body: '{}',
      remoteAddress: '10.0.0.1',
    );

    expect(result.statusCode, 401);
    expect(called, isFalse);
  });

  test('the request limit answers before calling Yandex again', () async {
    var calls = 0;
    final service = RecognizeService(
      config: _config(rateLimit: 1),
      callYandex: (call) async {
        calls += 1;
        return YandexReply(
          200,
          jsonEncode({
            'choices': [
              {
                'message': {
                  'content': '{"title":"Лист","summary":"Целый.","confidence":0.4,"plantId":"unknown","recommendations":[]}',
                },
              },
            ],
          }),
        );
      },
    );
    final body = jsonEncode({
      'imageBase64': base64Encode([9]),
      'mimeType': 'image/webp',
    });

    final first = await service.recognize(
      authorization: 'Bearer client-secret',
      body: body,
      remoteAddress: '10.1.1.1',
    );
    final second = await service.recognize(
      authorization: 'Bearer client-secret',
      body: body,
      remoteAddress: '10.1.1.1',
    );

    expect(first.statusCode, 200);
    expect(first.json['plantId'], isNull);
    expect(first.json['recommendations'], isNotEmpty);
    expect(second.statusCode, 429);
    expect(calls, 1);
  });

  test('the http server speaks the app contract', () async {
    final server = await startRecognizeServer(
      config: _config(),
      port: 0,
      callYandex: (call) async {
        return YandexReply(
          200,
          jsonEncode({
            'choices': [
              {
                'message': {
                  'content': '{"title":"Фикус","summary":"Лист целый.","confidence":0.6,"plantId":"ficus","recommendations":[{"title":"Свет","description":"Уберите от полуденного солнца.","topic":"light"}]}',
                },
              },
            ],
          }),
        );
      },
    );
    addTearDown(server.close);

    final client = HttpClient();
    addTearDown(client.close);
    final request = await client.postUrl(
      Uri.parse('http://127.0.0.1:${server.port}/v1/recognize'),
    );
    request.headers.set(
      HttpHeaders.authorizationHeader,
      'Bearer client-secret',
    );
    request.headers.contentType = ContentType.json;
    request.add(
      utf8.encode(
        jsonEncode({
          'imageBase64': base64Encode([4, 5]),
          'mimeType': 'image/jpeg',
        }),
      ),
    );
    final response = await request.close();
    final payload = jsonDecode(
      await response.transform(utf8.decoder).join(),
    ) as Map<String, dynamic>;

    expect(response.statusCode, 200);
    expect(payload['plantId'], 'ficus');
    expect((payload['recommendations'] as List), isNotEmpty);

    final healthRequest = await client.getUrl(
      Uri.parse('http://127.0.0.1:${server.port}/health'),
    );
    final health = await healthRequest.close();
    expect(health.statusCode, 200);
    await health.drain<void>();
  });
}
