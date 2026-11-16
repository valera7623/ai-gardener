import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../../../core/errors/app_exception.dart';
import '../../../shared/models/plant.dart';
import '../domain/recognition_connection.dart';
import 'recognition_request.dart';
import 'recognition_response.dart';

class HttpRecognitionApi {
  HttpRecognitionApi(
    this._client, {
    this.timeout = const Duration(seconds: 45),
  });

  final http.Client _client;
  final Duration timeout;

  static const maxImageBytes = 3500000;

  Future<RecognitionPayload> recognize({
    required Uint8List imageBytes,
    required String mimeType,
    required RecognitionConnection connection,
    required List<Plant> plants,
  }) async {
    if (!connection.isReady) {
      throw AppException(connection.missingMessage);
    }
    if (imageBytes.isEmpty) {
      throw const AppException('Фото пустое. Снимите его ещё раз.');
    }
    if (imageBytes.length > maxImageBytes) {
      throw const AppException(
        'Фото слишком большое. Снимите его ближе или выберите другое.',
      );
    }

    final imageBase64 = base64Encode(imageBytes);
    final Uri uri;
    final Map<String, Object?> payload;
    if (connection.backend == RecognitionBackend.yandex) {
      uri = Uri.parse(RecognitionConnection.yandexCompletionsUrl);
      payload = yandexRecognitionBody(
        connection: connection,
        imageBase64: imageBase64,
        mimeType: mimeType,
        plants: plants,
      );
    } else {
      try {
        uri = customRecognitionUri(connection.endpoint);
      } on FormatException catch (error) {
        throw AppException(error.message);
      }
      payload = customRecognitionBody(
        imageBase64: imageBase64,
        mimeType: mimeType,
      );
    }

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final apiKey = connection.apiKey.trim();
    if (apiKey.isNotEmpty) {
      headers['Authorization'] = 'Bearer $apiKey';
    }

    final http.Response response;
    try {
      response = await _client
          .post(uri, headers: headers, body: utf8.encode(jsonEncode(payload)))
          .timeout(timeout);
    } on TimeoutException {
      throw const AppException('Сервер долго не отвечает. Попробуйте ещё раз.');
    } on http.ClientException {
      throw const AppException(
        'Нет связи с сервисом распознавания. Проверьте интернет.',
      );
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw recognitionStatusError(response.statusCode);
    }
    return parseRecognitionBody(
      backend: connection.backend,
      body: response.body,
    );
  }
}
