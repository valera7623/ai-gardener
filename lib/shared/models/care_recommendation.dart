enum CareTopic {
  watering,
  light,
  temperature,
  feeding,
  pruning,
  planting,
  general,
}

class CareRecommendation {
  const CareRecommendation({
    required this.title,
    required this.description,
    this.topic = CareTopic.general,
  });

  final String title;
  final String description;
  final CareTopic topic;
}
