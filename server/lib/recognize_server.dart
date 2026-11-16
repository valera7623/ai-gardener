import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'recognize_service.dart';
import 'server_config.dart';

Future<HttpServer> startRecognizeServer({
  required ServerConfig config,
  required YandexCaller callYandex,
  InternetAddress? address,
  int? port,
}) async {
  final service = RecognizeService(config: config, callYandex: callYandex);
  final bindAddress = address ?? InternetAddress.loopbackIPv4;
  final bindPort = port ?? config.port;
  final HttpServer server;
  if (!config.usesTls) {
    server = await HttpServer.bind(bindAddress, bindPort);
  } else {
    final context = SecurityContext()
      ..useCertificateChain(config.tlsCertificatePath!)
      ..usePrivateKey(config.tlsPrivateKeyPath!);
    server = await HttpServer.bindSecure(bindAddress, bindPort, context);
  }
  server.listen((request) => unawaited(_dispatch(request, service)));
  return server;
}

Future<YandexReply> postToYandex(YandexCall call) async {
  final client = HttpClient();
  client.connectionTimeout = const Duration(seconds: 20);
  try {
    final request = await client
        .postUrl(call.uri)
        .timeout(const Duration(seconds: 40));
    request.headers.contentType = ContentType.json;
    request.headers.set(
      HttpHeaders.authorizationHeader,
      'Bearer ${call.apiKey}',
    );
    request.add(utf8.encode(call.body));
    final response = await request.close().timeout(const Duration(seconds: 40));
    final body = await response.transform(utf8.decoder).join();
    return YandexReply(response.statusCode, body);
  } on TimeoutException {
    return const YandexReply(504, '');
  } finally {
    client.close(force: true);
  }
}

Future<void> _dispatch(HttpRequest request, RecognizeService service) async {
  try {
    if (request.method == 'GET' && request.uri.path == '/health') {
      await _write(request, 200, {'status': 'ok'});
      return;
    }
    if (request.method != 'POST' || request.uri.path != '/v1/recognize') {
      await _write(request, 404, {'error': 'Не найдено'});
      return;
    }

    final bytes = <int>[];
    await for (final chunk in request) {
      if (bytes.length + chunk.length > 6000000) {
        await _write(request, 400, {'error': 'Фото слишком большое.'});
        return;
      }
      bytes.addAll(chunk);
    }
    final body = utf8.decode(bytes, allowMalformed: false);
    final result = await service.recognize(
      authorization: request.headers.value(HttpHeaders.authorizationHeader),
      body: body,
      remoteAddress: request.connectionInfo?.remoteAddress.address ?? 'unknown',
    );
    await _write(request, result.statusCode, result.json);
  } on FormatException {
    await _write(request, 400, {'error': 'Нужен JSON с фото.'});
  } catch (_) {
    await _write(request, 500, {'error': 'Сервер не смог обработать запрос.'});
  }
}

Future<void> _write(
  HttpRequest request,
  int status,
  Map<String, Object?> json,
) async {
  final response = request.response;
  response.statusCode = status;
  response.headers.contentType = ContentType.json;
  response.write(jsonEncode(json));
  await response.close();
}
