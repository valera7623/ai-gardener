import '../../../shared/models/plant.dart';
import '../domain/recognition_connection.dart';

Map<String, Object?> yandexRecognitionBody({
  required RecognitionConnection connection,
  required String imageBase64,
  required String mimeType,
  required List<Plant> plants,
}) {
  final catalog = plants
      .map((plant) => '${plant.id} — ${plant.name}')
      .join('\n');
  return {
    'model': connection.modelUri,
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
            'image_url': {'url': 'data:$mimeType;base64,$imageBase64'},
          },
        ],
      },
    ],
  };
}

Map<String, Object?> customRecognitionBody({
  required String imageBase64,
  required String mimeType,
}) {
  return {'imageBase64': imageBase64, 'mimeType': mimeType};
}

Uri customRecognitionUri(String endpoint) {
  final value = endpoint.trim();
  if (!value.startsWith('https://')) {
    throw const FormatException('Адрес сервера должен начинаться с https://');
  }
  final trimmed = value.endsWith('/')
      ? value.substring(0, value.length - 1)
      : value;
  if (trimmed.endsWith('/v1/recognize')) {
    return Uri.parse(trimmed);
  }
  return Uri.parse('$trimmed/v1/recognize');
}
