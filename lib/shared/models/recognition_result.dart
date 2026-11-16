import 'care_recommendation.dart';
import 'disease_match.dart';

class RecognitionResult {
  const RecognitionResult({
    required this.id,
    required this.title,
    required this.summary,
    required this.confidence,
    required this.recommendations,
    required this.createdAt,
    this.plantId,
    this.imagePath,
    this.isDemo = true,
    this.isOffline = false,
    this.matches = const [],
  });

  final String id;
  final String title;
  final String summary;
  final double confidence;
  final List<CareRecommendation> recommendations;
  final DateTime createdAt;
  final String? plantId;
  final String? imagePath;
  final bool isDemo;

  /// Оценка моделью на телефоне, без облачного запроса.
  final bool isOffline;
  final List<DiseaseMatch> matches;
}
