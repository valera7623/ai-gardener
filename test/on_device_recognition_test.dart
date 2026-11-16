import 'dart:io';

import 'package:ai_gardener/features/recognition/data/on_device_plant_recognizer.dart';
import 'package:ai_gardener/features/recognition/data/plant_disease_labels.dart';
import 'package:ai_gardener/features/recognition/data/repositories/offline_aware_recognition_repository.dart';
import 'package:ai_gardener/features/recognition/domain/repositories/recognition_repository.dart';
import 'package:ai_gardener/shared/models/care_recommendation.dart';
import 'package:ai_gardener/shared/models/recognition_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('labels.txt lists the 38 PlantVillage classes in model order', () {
    final labels = File('assets/models/labels.txt')
        .readAsLinesSync()
        .where((line) => line.trim().isNotEmpty)
        .toList();

    expect(labels, hasLength(38));
    expect(labels.first, 'Apple___Apple_scab');
    expect(labels.last, 'Tomato___healthy');
    expect(labels.toSet(), plantDiseaseTitles.keys.toSet());
  });

  test('efficientnet input maps a pixel into about -1..1', () {
    expect(efficientNetV2Input(0), -1);
    expect(efficientNetV2Input(255), closeTo(1, 0.01));
    expect(efficientNetV2Input(127.5), closeTo(0, 0.001));
  });

  test('top matches are the three highest probabilities', () {
    final labels = plantDiseaseTitles.keys.toList();
    final scores = List<double>.filled(labels.length, 0.002);
    scores[labels.indexOf('Tomato___Late_blight')] = 0.62;
    scores[labels.indexOf('Potato___Late_blight')] = 0.21;
    scores[labels.indexOf('Tomato___healthy')] = 0.1;

    final matches = topDiseaseMatches(scores: scores, labels: labels);

    expect(matches, hasLength(3));
    expect(matches.first.title, 'Фитофтороз томата');
    expect(matches.first.confidence, 0.62);
    expect(matches[1].title, 'Фитофтороз картофеля');
    expect(matches[2].title, 'Томат без видимой болезни');
  });

  test('logits become probabilities before ranking', () {
    final matches = topDiseaseMatches(
      scores: const [1, 3, 0],
      labels: const ['a', 'b', 'c'],
    );

    expect(matches.first.label, 'b');
    expect(matches.first.confidence, greaterThan(matches[1].confidence));
    final total = matches.fold<double>(
      0,
      (sum, match) => sum + match.confidence,
    );
    expect(total, closeTo(1, 0.02));
  });

  test('offline mode does not call the cloud repository', () async {
    final online = _FakeRepository(title: 'облако');
    final offline = _FakeRepository(title: 'телефон', offline: true);
    final repository = OfflineAwareRecognitionRepository(
      online: online,
      offline: offline,
      isOnline: () async => false,
    );

    final result = await repository.recognize(imagePath: '/tmp/leaf.jpg');

    expect(result.title, 'телефон');
    expect(result.isOffline, isTrue);
    expect(online.calls, 0);
    expect(offline.calls, 1);
  });

  test('online mode keeps the on-device model unused', () async {
    final online = _FakeRepository(title: 'облако');
    final offline = _FakeRepository(title: 'телефон', offline: true);
    final repository = OfflineAwareRecognitionRepository(
      online: online,
      offline: offline,
      isOnline: () async => true,
    );

    final result = await repository.recognize(imagePath: '/tmp/leaf.jpg');

    expect(result.title, 'облако');
    expect(online.calls, 1);
    expect(offline.calls, 0);
  });
}

class _FakeRepository implements RecognitionRepository {
  _FakeRepository({required this.title, this.offline = false});

  final String title;
  final bool offline;
  var calls = 0;

  @override
  Future<RecognitionResult> recognize({required String imagePath}) async {
    calls += 1;
    return RecognitionResult(
      id: title,
      title: title,
      summary: title,
      confidence: 0.5,
      recommendations: const [
        CareRecommendation(title: 'Свет', description: 'Оставьте на свету.'),
      ],
      createdAt: DateTime(2026, 11, 15),
      isDemo: false,
      isOffline: offline,
    );
  }
}
