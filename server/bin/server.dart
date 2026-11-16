import 'dart:io';

import 'package:ai_gardener_server/recognize_server.dart';
import 'package:ai_gardener_server/server_config.dart';

Future<void> main() async {
  final ServerConfig config;
  try {
    config = ServerConfig.fromEnvironment(Platform.environment);
  } on ServerConfigException catch (error) {
    stderr.writeln(error.message);
    exitCode = 64;
    return;
  }

  final server = await startRecognizeServer(
    config: config,
    callYandex: postToYandex,
    address: InternetAddress.anyIPv4,
    port: config.port,
  );
  final scheme = config.usesTls ? 'https' : 'http';
  stdout.writeln(
    'Сервер распознавания слушает $scheme://0.0.0.0:${server.port}.',
  );
  stdout.writeln(
    'Ключ Yandex остаётся в окружении и в приложение не передаётся.',
  );
}
