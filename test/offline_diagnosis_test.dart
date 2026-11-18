import 'dart:io';

import 'package:ai_gardener/features/recognition/data/offline_diagnosis_service.dart';
import 'package:ai_gardener/features/recognition/data/plant_disease_labels.dart';
import 'package:ai_gardener/features/recognition/data/repositories/on_device_recognition_repository.dart';
import 'package:ai_gardener/features/recognition/domain/offline_diagnosis.dart';
import 'package:ai_gardener/features/recognition/presentation/screens/recognition_result_screen.dart';
import 'package:ai_gardener/shared/models/disease_match.dart';
import 'package:ai_gardener/shared/models/recognition_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('offline cards cover every model label', () {
    final labels = File('assets/models/labels.txt')
        .readAsLinesSync()
        .where((line) => line.trim().isNotEmpty)
        .map((line) => line.trim())
        .toList();
    final catalog = parseOfflineDiagnoses(
      File('assets/data/offline_diagnoses.json').readAsStringSync(),
    );

    expect(catalog.keys.toList(), labels);
    for (final diagnosis in catalog.values) {
      expect(diagnosis.russianName, plantDiseaseTitles[diagnosis.englishName]);
      expect(diagnosis.shortDescription, isNotEmpty);
      expect(diagnosis.recommendations.length, inInclusiveRange(3, 5));
      expect(
        diagnosis.recommendations.every(
          (item) => item.title.isNotEmpty && item.description.isNotEmpty,
        ),
        isTrue,
      );
    }
    expect(catalog['Tomato___healthy']!.isHealthy, isTrue);
    expect(catalog['Tomato___Late_blight']!.isHealthy, isFalse);
    expect(catalog['Tomato___Late_blight']!.severity, OfflineSeverity.high);
  });

  test('a missing class and a broken file stay safe', () async {
    final service = OfflineDiagnosisService(
      loadAsset: () async =>
          File('assets/data/offline_diagnoses.json').readAsStringSync(),
    );
    final known = await service.getDiagnosis('Potato___Late_blight');
    expect(known.russianName, 'Фитофтороз картофеля');

    final missing = await service.getDiagnosis('Not_a_class');
    expect(missing.russianName, 'Оценка без карточки');
    expect(missing.recommendations, isNotEmpty);

    final broken = OfflineDiagnosisService(loadAsset: () async => '{');
    final fallback = await broken.getDiagnosis('Tomato___healthy');
    expect(fallback.russianName, 'Томат без видимой болезни');
    expect(fallback.recommendations, isNotEmpty);
  });

  test('offline result uses the same fields as a cloud result', () {
    final catalog = parseOfflineDiagnoses(
      File('assets/data/offline_diagnoses.json').readAsStringSync(),
    );
    final diagnosis = catalog['Tomato___Late_blight']!;
    final result = offlineRecognitionResult(
      assessment: OnDeviceAssessment(
        matches: const [
          DiseaseMatch(
            label: 'Tomato___Late_blight',
            title: 'старое имя',
            confidence: 0.42,
          ),
          DiseaseMatch(
            label: 'Potato___Late_blight',
            title: 'Фитофтороз картофеля',
            confidence: 0.2,
          ),
        ],
        diagnosis: diagnosis,
      ),
      imagePath: '/tmp/leaf.jpg',
      plantId: 'tomato',
      createdAt: DateTime.utc(2026, 6, 1, 9),
    );

    expect(result.title, 'Фитофтороз томата');
    expect(result.summary, diagnosis.shortDescription);
    expect(result.confidence, 0.42);
    expect(result.recommendations, diagnosis.recommendations);
    expect(result.plantId, 'tomato');
    expect(result.isDemo, isFalse);
    expect(result.isOffline, isTrue);
    expect(result.isOnDeviceAssessment, isTrue);
    expect(result.id, startsWith('device-'));
  });

  testWidgets('a low-confidence offline result warns the user', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: RecognitionResultScreen(
            result: RecognitionResult(
              id: 'device-1',
              title: 'Фитофтороз томата',
              summary: 'Листья быстро буреют.',
              confidence: 0.42,
              recommendations: const [],
              createdAt: DateTime.utc(2026, 6, 1),
              isDemo: false,
              isOffline: true,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Оценка на устройстве'), findsOneWidget);
    expect(find.text('Без интернета'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Уверенность модели: 42%'), 200);
    expect(find.text('Уверенность модели: 42%'), findsOneWidget);
    expect(
      find.text(
        'Модель не уверена, лучше сделать фото при хорошем освещении или использовать онлайн-режим',
      ),
      findsOneWidget,
    );
  });
}
