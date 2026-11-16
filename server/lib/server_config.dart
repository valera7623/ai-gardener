import 'dart:io';

class ServerConfig {
  const ServerConfig({
    required this.yandexApiKey,
    required this.clientApiKey,
    this.folderId = '',
    this.model = defaultModel,
    this.port = 8080,
    this.bindAddress = '127.0.0.1',
    this.maxImageBytes = 3500000,
    this.rateLimit = 20,
    this.rateWindow = const Duration(minutes: 10),
    this.yandexUri = defaultYandexUri,
    this.tlsCertificatePath,
    this.tlsPrivateKeyPath,
  });

  static const defaultModel = 'deepseek-v4.1-flash';
  static const defaultYandexUri =
      'https://ai.api.cloud.yandex.net/v1/chat/completions';

  final String yandexApiKey;
  final String clientApiKey;
  final String folderId;
  final String model;
  final int port;
  /// `127.0.0.1` за reverse proxy, `0.0.0.0` если нужен прямой доступ.
  final String bindAddress;
  final int maxImageBytes;
  final int rateLimit;
  final Duration rateWindow;
  final String yandexUri;
  final String? tlsCertificatePath;
  final String? tlsPrivateKeyPath;

  bool get usesTls =>
      (tlsCertificatePath ?? '').isNotEmpty &&
      (tlsPrivateKeyPath ?? '').isNotEmpty;

  String get modelUri {
    final selected = model.trim().isEmpty ? defaultModel : model.trim();
    if (selected.contains('://')) {
      return selected;
    }
    final folder = folderId.trim();
    if (folder.isEmpty) {
      return selected;
    }
    return 'gpt://$folder/$selected/latest';
  }

  static ServerConfig fromEnvironment(Map<String, String> env) {
    final yandexApiKey = (env['YANDEX_API_KEY'] ?? '').trim();
    final clientApiKey = (env['CLIENT_API_KEY'] ?? '').trim();
    if (yandexApiKey.isEmpty) {
      throw const ServerConfigException(
        'Задайте YANDEX_API_KEY в окружении сервера.',
      );
    }
    if (clientApiKey.isEmpty) {
      throw const ServerConfigException(
        'Задайте CLIENT_API_KEY в окружении сервера.',
      );
    }
    if (yandexApiKey == clientApiKey) {
      throw const ServerConfigException(
        'CLIENT_API_KEY и YANDEX_API_KEY должны быть разными.',
      );
    }
    final certificate = (env['TLS_CERT_PATH'] ?? '').trim();
    final privateKey = (env['TLS_KEY_PATH'] ?? '').trim();
    if (certificate.isEmpty != privateKey.isEmpty) {
      throw const ServerConfigException(
        'Для HTTPS задайте оба пути: TLS_CERT_PATH и TLS_KEY_PATH.',
      );
    }
    if (certificate.isNotEmpty &&
        (!File(certificate).existsSync() || !File(privateKey).existsSync())) {
      throw const ServerConfigException(
        'Не найден сертификат HTTPS или его закрытый ключ.',
      );
    }
    return ServerConfig(
      yandexApiKey: yandexApiKey,
      clientApiKey: clientApiKey,
      folderId: (env['YANDEX_FOLDER_ID'] ?? '').trim(),
      model: (env['YANDEX_MODEL'] ?? '').trim().isEmpty
          ? defaultModel
          : env['YANDEX_MODEL']!.trim(),
      port: _port(env['PORT'], tls: certificate.isNotEmpty),
      bindAddress: _bindAddress(env['BIND_ADDRESS']),
      tlsCertificatePath: certificate.isEmpty ? null : certificate,
      tlsPrivateKeyPath: privateKey.isEmpty ? null : privateKey,
    );
  }

  static String _bindAddress(String? value) {
    final address = (value ?? '').trim();
    if (address.isEmpty) {
      return '127.0.0.1';
    }
    return address;
  }

  static int _port(String? value, {required bool tls}) {
    if (value == null || value.trim().isEmpty) {
      return tls ? 8443 : 8080;
    }
    final port = int.tryParse(value.trim());
    if (port == null || port < 1 || port > 65535) {
      throw const ServerConfigException(
        'PORT должен быть числом от 1 до 65535.',
      );
    }
    return port;
  }
}

class ServerConfigException implements Exception {
  const ServerConfigException(this.message);

  final String message;

  @override
  String toString() => message;
}
