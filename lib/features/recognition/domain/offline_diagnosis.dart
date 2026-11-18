import '../../../shared/models/care_recommendation.dart';
import '../../../shared/models/disease_match.dart';

enum OfflineSeverity {
  low,
  medium,
  high;

  static OfflineSeverity parse(Object? raw) {
    return switch (raw) {
      'low' => OfflineSeverity.low,
      'high' => OfflineSeverity.high,
      _ => OfflineSeverity.medium,
    };
  }
}

class OfflineDiagnosis {
  const OfflineDiagnosis({
    required this.englishName,
    required this.russianName,
    required this.shortDescription,
    required this.recommendations,
    required this.severity,
    required this.isHealthy,
  });

  final String englishName;
  final String russianName;
  final String shortDescription;
  final List<CareRecommendation> recommendations;
  final OfflineSeverity severity;
  final bool isHealthy;

  /// Карточка, если класса нет в базе или файл не прочитался.
  factory OfflineDiagnosis.fallback(
    String englishLabel, {
    String? russianName,
  }) {
    final title = russianName?.trim();
    return OfflineDiagnosis(
      englishName: englishLabel.trim(),
      russianName: title == null || title.isEmpty
          ? 'Оценка без карточки'
          : title,
      shortDescription: 'Для этого класса нет подробной карточки на телефоне. Сверьте лист при дневном свете и не обрабатывайте растение наугад.',
      recommendations: const [
        CareRecommendation(
          title: 'Осмотрите лист ещё раз',
          description: 'Посмотрите его при дневном свете и сравните с соседними листьями.',
          topic: CareTopic.light,
        ),
        CareRecommendation(
          title: 'Не обрабатывайте наугад',
          description: 'Без уверенного совпадения не опрыскивайте растение и не обрывайте его целиком.',
        ),
        CareRecommendation(
          title: 'Повторите при интернете',
          description: 'Когда появится сеть, по этому же фото можно получить более подробную подсказку.',
        ),
      ],
      severity: OfflineSeverity.medium,
      isHealthy: false,
    );
  }

  static OfflineDiagnosis? tryParse(Object? raw) {
    if (raw is! Map) {
      return null;
    }
    final english = raw['english_name'];
    final russian = raw['russian_name'];
    final description = raw['short_description'];
    final recommendationsRaw = raw['recommendations'];
    if (english is! String || english.trim().isEmpty) {
      return null;
    }
    if (russian is! String || russian.trim().isEmpty) {
      return null;
    }
    if (description is! String || description.trim().isEmpty) {
      return null;
    }
    if (recommendationsRaw is! List) {
      return null;
    }
    final recommendations = [
      for (final item in recommendationsRaw) ?_recommendation(item),
    ];
    if (recommendations.isEmpty) {
      return null;
    }
    return OfflineDiagnosis(
      englishName: english.trim(),
      russianName: russian.trim(),
      shortDescription: description.trim(),
      recommendations: recommendations,
      severity: OfflineSeverity.parse(raw['severity']),
      isHealthy: raw['is_healthy'] == true,
    );
  }
}

class OnDeviceAssessment {
  const OnDeviceAssessment({required this.matches, required this.diagnosis});

  final List<DiseaseMatch> matches;
  final OfflineDiagnosis diagnosis;
}

CareRecommendation? _recommendation(Object? raw) {
  if (raw is String) {
    final text = raw.trim();
    if (text.isEmpty) {
      return null;
    }
    return CareRecommendation(title: text, description: text);
  }
  if (raw is! Map) {
    return null;
  }
  final title = raw['title'];
  final description = raw['description'];
  if (title is! String || title.trim().isEmpty) {
    return null;
  }
  if (description is! String || description.trim().isEmpty) {
    return null;
  }
  return CareRecommendation(
    title: title.trim(),
    description: description.trim(),
    topic: _topic(raw['topic']),
  );
}

CareTopic _topic(Object? raw) {
  if (raw is! String) {
    return CareTopic.general;
  }
  for (final topic in CareTopic.values) {
    if (topic.name == raw) {
      return topic;
    }
  }
  return CareTopic.general;
}
