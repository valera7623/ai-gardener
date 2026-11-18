import 'dart:convert';
import 'dart:io';

import 'package:ai_gardener/core/errors/app_exception.dart';
import 'package:ai_gardener/features/catalog/data/datasources/plant_catalog_local_datasource.dart';
import 'package:ai_gardener/features/catalog/data/repositories/plant_catalog_repository_impl.dart';
import 'package:ai_gardener/features/recognition/data/http_recognition_api.dart';
import 'package:ai_gardener/features/recognition/data/recognition_request.dart';
import 'package:ai_gardener/features/recognition/data/recognition_response.dart';
import 'package:ai_gardener/features/recognition/data/repositories/recognition_repository_impl.dart';
import 'package:ai_gardener/features/recognition/domain/recognition_connection.dart';
import 'package:ai_gardener/shared/models/care_recommendation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

http.Response jsonResponse(Object body, int statusCode) {
  return http.Response(
    jsonEncode(body),
    statusCode,
    headers: {'content-type': 'application/json; charset=utf-8'},
  );
}

void main() {
  const catalog = PlantCatalogRepositoryImpl(PlantCatalogLocalDataSource());

  test('yandex answer with a code fence becomes a catalog result', () async {
    final directory = await Directory.systemTemp.createTemp(
      'ai_gardener_photo',
    );
    final photo = File('${directory.path}/leaf.jpg')
      ..writeAsBytesSync([1, 2, 3]);
    addTearDown(() => directory.delete(recursive: true));

    final client = MockClient((request) async {
      expect(
        request.url.toString(),
        RecognitionConnection.yandexCompletionsUrl,
      );
      expect(request.headers['authorization'], 'Bearer test-key');
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      expect(body['model'], 'gpt://b1gfolder/deepseek-v4.1-flash/latest');
      expect(jsonEncode(body).contains('test-key'), isFalse);
      return jsonResponse({
        'choices': [
          {
            'message': {
              'content': '```json\n{"title":"Тля на розе","summary":"На бутонах видна колония.","confidence":80,"plantId":"rose","recommendations":[{"title":"Смыть","description":"Смойте тлю тёплой водой.","topic":"general"}]}\n```',
            },
          },
        ],
      }, 200);
    });

    final result = await RecognitionRepositoryImpl(
      api: HttpRecognitionApi(client),
      catalog: catalog,
      readConnection: () => const RecognitionConnection(
        backend: RecognitionBackend.yandex,
        apiKey: 'test-key',
        folderId: 'b1gfolder',
      ),
    ).recognize(imagePath: photo.path);

    expect(result.isDemo, isFalse);
    expect(result.title, 'Тля на розе');
    expect(result.plantId, 'rose');
    expect(result.confidence, 0.8);
    expect(result.recommendations.single.topic, CareTopic.general);
    expect(result.imagePath, photo.path);
  });

  test('unknown plant id is not linked to the catalog', () async {
    final directory = await Directory.systemTemp.createTemp(
      'ai_gardener_photo',
    );
    final photo = File('${directory.path}/leaf.jpg')..writeAsBytesSync([9]);
    addTearDown(() => directory.delete(recursive: true));
    final client = MockClient((request) async {
      expect(request.url.path, '/v1/recognize');
      return jsonResponse({
        'title': 'Пятна на листе',
        'summary': 'Похоже на ожог или начало пятнистости.',
        'confidence': 0.42,
        'plantId': 'unknown-plant',
        'recommendations': [
          {
            'title': 'Свет',
            'description': 'Уберите растение с прямого полуденного солнца.',
            'topic': 'light',
          },
        ],
      }, 200);
    });

    final result = await RecognitionRepositoryImpl(
      api: HttpRecognitionApi(client),
      catalog: catalog,
      readConnection: () => const RecognitionConnection(
        backend: RecognitionBackend.custom,
        endpoint: 'https://garden.example.ru/',
      ),
    ).recognize(imagePath: photo.path);

    expect(result.plantId, isNull);
    expect(result.recommendations.single.topic, CareTopic.light);
  });

  test('a rejected key does not pretend the photo was recognized', () async {
    final directory = await Directory.systemTemp.createTemp(
      'ai_gardener_photo',
    );
    final photo = File('${directory.path}/leaf.jpg')..writeAsBytesSync([4]);
    addTearDown(() => directory.delete(recursive: true));
    final client = MockClient(
      (request) async => jsonResponse({'error': 'unauthorized'}, 401),
    );

    await expectLater(
      RecognitionRepositoryImpl(
        api: HttpRecognitionApi(client),
        catalog: catalog,
        readConnection: () => const RecognitionConnection(
          backend: RecognitionBackend.yandex,
          apiKey: 'bad',
        ),
      ).recognize(imagePath: photo.path),
      throwsA(
        isA<AppException>().having(
          (error) => error.message,
          'message',
          contains('Ключ не подошёл'),
        ),
      ),
    );
  });

  test('missing connection does not call the service', () async {
    final directory = await Directory.systemTemp.createTemp(
      'ai_gardener_photo',
    );
    final photo = File('${directory.path}/leaf.jpg')..writeAsBytesSync([5]);
    addTearDown(() => directory.delete(recursive: true));
    var called = false;
    final client = MockClient((request) async {
      called = true;
      return http.Response('{}', 200);
    });

    await expectLater(
      RecognitionRepositoryImpl(
        api: HttpRecognitionApi(client),
        catalog: catalog,
        readConnection: () =>
            const RecognitionConnection(backend: RecognitionBackend.custom),
      ).recognize(imagePath: photo.path),
      throwsA(isA<AppException>()),
    );
    expect(called, isFalse);
  });

  test('a plain http address is rejected', () {
    expect(
      () => customRecognitionUri('http://garden.example.ru'),
      throwsFormatException,
    );
  });

  test('confidence above one is treated as percent', () {
    final payload = parseRecognitionPayload({
      'title': 'Фикус',
      'summary': 'Листья целые.',
      'confidence': '74',
      'recommendations': [],
    });

    expect(payload.confidence, 0.74);
    expect(payload.recommendations, isNotEmpty);
  });
}
