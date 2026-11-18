import 'dart:io';

import '../../../../core/errors/app_exception.dart';
import '../../../../shared/models/recognition_result.dart';
import '../../domain/offline_diagnosis.dart';
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
    final assessment = await _recognizer.recognizeBytes(
      await file.readAsBytes(),
    );
    if (assessment.matches.isEmpty) {
      throw const AppException('Модель не смогла оценить это фото.');
    }
    final top = assessment.matches.first;
    return offlineRecognitionResult(
      assessment: assessment,
      imagePath: imagePath,
      plantId: plantDiseaseCatalogIds[top.label],
    );
  }
}

/// Тот же набор полей, что у облачного результата: название, описание и действия.
RecognitionResult offlineRecognitionResult({
  required OnDeviceAssessment assessment,
  required String imagePath,
  String? plantId,
  DateTime? createdAt,
}) {
  final top = assessment.matches.first;
  final diagnosis = assessment.diagnosis;
  final moment = createdAt ?? DateTime.now();
  return RecognitionResult(
    id: 'device-${moment.microsecondsSinceEpoch}',
    title: diagnosis.russianName,
    summary: diagnosis.shortDescription,
    confidence: top.confidence,
    recommendations: diagnosis.recommendations,
    createdAt: moment,
    plantId: plantId,
    imagePath: imagePath,
    isDemo: false,
    isOffline: true,
    matches: assessment.matches,
  );
}
