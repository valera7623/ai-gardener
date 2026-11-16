import '../../../../shared/models/care_recommendation.dart';
import '../../../../shared/models/recognition_result.dart';
import 'recognition_record.dart';

RecognitionRecord recognitionRecordFromResult(RecognitionResult result) {
  return RecognitionRecord()
    ..resultId = result.id
    ..title = result.title
    ..summary = result.summary
    ..confidence = result.confidence
    ..plantId = result.plantId
    ..imagePath = result.imagePath
    ..isDemo = result.isDemo
    ..createdAt = result.createdAt
    ..recommendations = [
      for (final item in result.recommendations)
        StoredRecommendation()
          ..title = item.title
          ..description = item.description
          ..topic = item.topic.name,
    ];
}

RecognitionResult recognitionResultFromRecord(RecognitionRecord record) {
  return RecognitionResult(
    id: record.resultId,
    title: record.title,
    summary: record.summary,
    confidence: record.confidence,
    recommendations: [
      for (final item in record.recommendations)
        CareRecommendation(
          title: item.title,
          description: item.description,
          topic: _topic(item.topic),
        ),
    ],
    createdAt: record.createdAt,
    plantId: record.plantId,
    imagePath: record.imagePath,
    isDemo: record.isDemo,
  );
}

CareTopic _topic(String name) {
  for (final topic in CareTopic.values) {
    if (topic.name == name) {
      return topic;
    }
  }
  return CareTopic.general;
}
