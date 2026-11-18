import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../core/errors/app_exception.dart';
import '../../../shared/models/disease_match.dart';
import '../domain/offline_diagnosis.dart';
import 'offline_diagnosis_service.dart';
import 'plant_disease_labels.dart';

/// Оффлайн-оценка фото моделью EfficientNetV2S на 38 классов PlantVillage.
/// Модель загружается один раз и живёт, пока провайдер её не закроет.
class OnDevicePlantRecognizer {
  OnDevicePlantRecognizer({OfflineDiagnosisService? diagnoses})
    : _diagnoses = diagnoses ?? OfflineDiagnosisService();

  final OfflineDiagnosisService _diagnoses;
  Interpreter? _interpreter;
  List<String>? _labels;

  Future<OnDeviceAssessment> recognizeBytes(Uint8List bytes) async {
    if (bytes.isEmpty) {
      throw const AppException('Фото пустое. Снимите его ещё раз.');
    }
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw const AppException(
        'Не удалось прочитать фото. Выберите его ещё раз.',
      );
    }
    final interpreter = await _load();
    final inputShape = interpreter.getInputTensor(0).shape;
    if (inputShape.length != 4 || inputShape[3] != 3) {
      throw const AppException('Модель на телефоне ожидает другое фото.');
    }
    final height = inputShape[1];
    final width = inputShape[2];
    final resized = img.copyResize(
      decoded,
      width: width,
      height: height,
      interpolation: img.Interpolation.linear,
    );
    // Вход keras EfficientNetV2: один кадр RGB, значения около [-1, 1].
    final input = [
      [
        for (var y = 0; y < height; y++)
          [
            for (var x = 0; x < width; x++)
              [
                efficientNetV2Input(resized.getPixel(x, y).r),
                efficientNetV2Input(resized.getPixel(x, y).g),
                efficientNetV2Input(resized.getPixel(x, y).b),
              ],
          ],
      ],
    ];
    final outputShape = interpreter.getOutputTensor(0).shape;
    final classCount = outputShape.last;
    if (classCount != _labels!.length) {
      throw const AppException(
        'Список классов не совпадает с моделью на телефоне.',
      );
    }
    // Буфер повторяет форму выхода, обычно [1, 38].
    final output = _zeroOutput(outputShape);
    try {
      interpreter.run(input, output);
    } catch (_) {
      throw const AppException(
        'Не удалось оценить фото на телефоне. Попробуйте ещё раз.',
      );
    }
    final matches = topDiseaseMatches(
      scores: _classScores(output),
      labels: _labels!,
    );
    if (matches.isEmpty) {
      throw const AppException('Модель не смогла оценить это фото.');
    }
    return _withDiagnoses(matches);
  }

  Future<OnDeviceAssessment> _withDiagnoses(List<DiseaseMatch> matches) async {
    try {
      final diagnosis = await _diagnoses.getDiagnosis(matches.first.label);
      final titled = <DiseaseMatch>[];
      for (final match in matches) {
        final card = match.label == diagnosis.englishName
            ? diagnosis
            : await _diagnoses.getDiagnosis(match.label);
        titled.add(
          DiseaseMatch(
            label: match.label,
            title: card.russianName,
            confidence: match.confidence,
          ),
        );
      }
      return OnDeviceAssessment(matches: titled, diagnosis: diagnosis);
    } catch (_) {
      return OnDeviceAssessment(
        matches: matches,
        diagnosis: OfflineDiagnosis.fallback(
          matches.first.label,
          russianName: plantDiseaseTitles[matches.first.label],
        ),
      );
    }
  }

  Future<Interpreter> _load() async {
    final existing = _interpreter;
    if (existing != null) {
      return existing;
    }
    try {
      _labels = await _readLabels();
      final interpreter = await Interpreter.fromAsset(
        'assets/models/plant_disease.tflite',
      );
      _interpreter = interpreter;
      return interpreter;
    } on AppException {
      rethrow;
    } catch (_) {
      throw const AppException('Не удалось загрузить модель на телефоне.');
    }
  }

  Future<List<String>> _readLabels() async {
    final raw = await rootBundle.loadString('assets/models/labels.txt');
    final labels = [
      for (final line in raw.split('\n'))
        if (line.trim().isNotEmpty) line.trim(),
    ];
    if (labels.length != plantDiseaseTitles.length) {
      throw const AppException('Список классов модели на телефоне повреждён.');
    }
    return labels;
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
    _labels = null;
  }
}

List<dynamic> _zeroOutput(List<int> shape) {
  if (shape.isEmpty || shape.any((size) => size <= 0)) {
    throw const AppException('Модель на телефоне вернула пустой ответ.');
  }
  if (shape.length == 1) {
    return List<double>.filled(shape.first, 0);
  }
  return List.generate(shape.first, (_) => _zeroOutput(shape.sublist(1)));
}

List<double> _classScores(Object output) {
  var current = output;
  while (current is List && current.isNotEmpty && current.first is List) {
    current = current.first;
  }
  if (current is! List || current.isEmpty) {
    throw const AppException('Модель вернула неожиданный ответ.');
  }
  return [for (final value in current) (value as num).toDouble()];
}

List<DiseaseMatch> topDiseaseMatches({
  required List<double> scores,
  required List<String> labels,
  int count = 3,
}) {
  final probabilities = asProbabilities(scores);
  if (probabilities.length != labels.length) {
    throw const AppException('Модель вернула неожиданный ответ.');
  }
  final order = List<int>.generate(labels.length, (index) => index)
    ..sort((a, b) => probabilities[b].compareTo(probabilities[a]));
  return [
    for (final index in order.take(count))
      DiseaseMatch(
        label: labels[index],
        title: plantDiseaseTitles[labels[index]] ?? labels[index],
        confidence: probabilities[index].clamp(0, 1).toDouble(),
      ),
  ];
}
