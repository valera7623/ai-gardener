import 'package:isar_community/isar.dart';

part 'recognition_record.g.dart';

@collection
class RecognitionRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String resultId;

  late String title;
  late String summary;
  late double confidence;
  String? plantId;
  String? imagePath;
  late bool isDemo;

  @Index()
  late DateTime createdAt;

  List<StoredRecommendation> recommendations = [];
}

@embedded
class StoredRecommendation {
  String title = '';
  String description = '';
  String topic = 'general';
}
