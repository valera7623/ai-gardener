import 'dart:io';

import '../../../../core/errors/app_exception.dart';
import '../../../../shared/models/care_recommendation.dart';
import '../../../../shared/models/recognition_result.dart';
import '../../domain/repositories/recognition_repository.dart';
import '../on_device_plant_recognizer.dart';
import '../plant_disease_labels.dart';

class OnDeviceRecognitionRepository implements RecognitionRepository {
  const OnDeviceRecognitionRepository(this._recognizer);

  final OnDevicePlantRecognizer _recognizer;

  @override
  Future<RecognitionResult> recognize({required String imagePath}) async {
    final file = File(imagePath);
    if (!await file.exists()) {
      throw const AppException(
        'Не удалось прочитать фото. Выберите его ещё раз.',
      );
    }
    final matches = await _recognizer.recognizeBytes(await file.readAsBytes());
    if (matches.isEmpty) {
      throw const AppException('Модель не смогла оценить это фото.');
    }
    final top = matches.first;
    final others = matches
        .skip(1)
        .map((match) => '${match.title} (${(match.confidence * 100).round()}%)')
        .join(', ');
    return RecognitionResult(
      id: 'device-${DateTime.now().microsecondsSinceEpoch}',
      title: top.title,
      summary: others.isEmpty
          ? 'Без интернета. Модель на телефоне сравнила лист с известными болезнями.'
          : 'Без интернета. Модель на телефоне сравнила лист с известными болезнями. Дальше по вероятности: $others.',
      confidence: top.confidence,
      recommendations: const [
        CareRecommendation(
          title: 'Сверьте ещё раз',
          description: 'Это оценка по фото без интернета. Посмотрите лист при дневном свете и сравните его с соседними.',
        ),
      ],
      createdAt: DateTime.now(),
      plantId: plantDiseaseCatalogIds[top.label],
      imagePath: imagePath,
      isDemo: false,
      isOffline: true,
      matches: matches,
    );
  }
}
