import 'care_recommendation.dart';

enum PlantCategory {
  indoor,
  garden;

  String get label => switch (this) {
    PlantCategory.indoor => 'Комнатное',
    PlantCategory.garden => 'Садовое',
  };
}

class Plant {
  const Plant({
    required this.id,
    required this.name,
    required this.latinName,
    required this.category,
    required this.summary,
    required this.care,
    this.commonProblems = const [],
  });

  final String id;
  final String name;
  final String latinName;
  final PlantCategory category;
  final String summary;
  final List<CareRecommendation> care;
  final List<String> commonProblems;
}
