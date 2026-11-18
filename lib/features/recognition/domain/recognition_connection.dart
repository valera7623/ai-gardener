enum RecognitionBackend {
  yandex,
  custom;

  String get label => switch (this) {
    RecognitionBackend.yandex => 'Yandex AI Studio',
    RecognitionBackend.custom => 'Свой сервер',
  };
}

class RecognitionConnection {
  const RecognitionConnection({
    required this.backend,
    this.apiKey = '',
    this.endpoint = '',
    this.model = defaultModel,
    this.folderId = '',
  });

  static const defaultModel = 'deepseek-v4.1-flash';
  static const serviceEndpoint = 'https://aegisai.fun';
  static const clientKey = 'b6c7115ff307b8e8cc80b0b615c519bb572330da61ab16eb';
  static const yandexCompletionsUrl =
      'https://ai.api.cloud.yandex.net/v1/chat/completions';

  final RecognitionBackend backend;
  final String apiKey;
  final String endpoint;
  final String model;
  final String folderId;

  static const defaults = RecognitionConnection(
    backend: RecognitionBackend.custom,
    endpoint: serviceEndpoint,
    apiKey: clientKey,
  );

  bool get isReady => switch (backend) {
    RecognitionBackend.yandex => apiKey.trim().isNotEmpty,
    RecognitionBackend.custom => endpoint.trim().isNotEmpty,
  };

  String get missingMessage => switch (backend) {
    RecognitionBackend.yandex => 'Добавьте ключ Yandex AI Studio в настройках.',
    RecognitionBackend.custom => 'Укажите адрес своего сервера в настройках.',
  };

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
}
