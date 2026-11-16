import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ai_gardener/core/errors/app_exception.dart';
import 'package:ai_gardener/features/catalog/data/datasources/plant_catalog_local_datasource.dart';
import 'package:ai_gardener/features/catalog/data/repositories/plant_catalog_repository_impl.dart';
import 'package:ai_gardener/features/recognition/data/http_recognition_api.dart';
import 'package:ai_gardener/features/recognition/data/recognition_image.dart';
import 'package:ai_gardener/features/recognition/data/repositories/recognition_repository_impl.dart';
import 'package:ai_gardener/features/recognition/domain/recognition_connection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:image/image.dart' as img;

void main() {
  test('a small jpeg is sent unchanged', () {
    final source = img.encodeJpg(img.Image(width: 32, height: 24), quality: 80);

    final prepared = prepareRecognitionImage(source);

    expect(identical(prepared.bytes, source), isTrue);
    expect(prepared.mimeType, 'image/jpeg');
  });

  test('a wide photo is scaled and sent as jpeg', () {
    final source = img.Image(width: 2000, height: 800);
    img.fill(source, color: img.ColorRgb8(18, 110, 46));
    final png = img.encodePng(source);

    final prepared = prepareRecognitionImage(png);
    final decoded = img.decodeJpg(prepared.bytes);

    expect(prepared.mimeType, 'image/jpeg');
    expect(decoded, isNotNull);
    expect(decoded!.width, lessThanOrEqualTo(recognitionImageMaxSide));
    expect(decoded.height, lessThanOrEqualTo(recognitionImageMaxSide));
    expect(
      prepared.bytes.length,
      lessThanOrEqualTo(HttpRecognitionApi.maxImageBytes),
    );
  });

  test('a photo above the limit is reduced until it fits', () {
    final noisy = img.Image(width: 240, height: 240);
    for (var i = 0; i < noisy.width * noisy.height; i++) {
      noisy.setPixelRgb(
        i % noisy.width,
        i ~/ noisy.width,
        (i * 17) & 255,
        (i * 31) & 255,
        (i * 13) & 255,
      );
    }
    final source = img.encodeJpg(noisy, quality: 100);
    final limit = source.length ~/ 4;

    final prepared = prepareRecognitionImage(source, maxBytes: limit);

    expect(source.length, greaterThan(limit));
    expect(prepared.bytes.length, lessThanOrEqualTo(limit));
    expect(prepared.mimeType, 'image/jpeg');
    expect(img.decodeJpg(prepared.bytes), isNotNull);
  });

  test('bytes that cannot be decoded and exceed the limit are rejected', () {
    expect(
      () => prepareRecognitionImage(
        Uint8List.fromList([1, 2, 3, 4]),
        maxBytes: 3,
      ),
      throwsA(isA<AppException>()),
    );
  });

  test('recognition uploads the compressed photo and keeps the file', () async {
    final directory = await Directory.systemTemp.createTemp(
      'ai_gardener_photo',
    );
    addTearDown(() => directory.delete(recursive: true));
    final source = img.Image(width: 1800, height: 900);
    img.fill(source, color: img.ColorRgb8(40, 140, 70));
    final png = img.encodePng(source);
    final photo = File('${directory.path}/leaf.png')..writeAsBytesSync(png);

    late Uint8List uploaded;
    final client = MockClient((request) async {
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      expect(body['mimeType'], 'image/jpeg');
      uploaded = base64Decode(body['imageBase64'] as String);
      return http.Response(
        jsonEncode({
          'title': 'Лист',
          'summary': 'Повреждений не видно.',
          'confidence': 0.5,
          'recommendations': [
            {
              'title': 'Полив',
              'description': 'Полейте, когда верх земли подсохнет.',
              'topic': 'watering',
            },
          ],
        }),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });

    await RecognitionRepositoryImpl(
      api: HttpRecognitionApi(client),
      catalog: const PlantCatalogRepositoryImpl(PlantCatalogLocalDataSource()),
      readConnection: () => const RecognitionConnection(
        backend: RecognitionBackend.custom,
        endpoint: 'https://garden.example.ru',
      ),
    ).recognize(imagePath: photo.path);

    expect(img.decodeJpg(uploaded)!.width, lessThanOrEqualTo(1600));
    expect(photo.readAsBytesSync(), png);
  });
}
