class DiseaseMatch {
  const DiseaseMatch({
    required this.label,
    required this.title,
    required this.confidence,
  });

  /// Имя класса из labels.txt, в порядке выхода модели.
  final String label;

  final String title;
  final double confidence;
}
