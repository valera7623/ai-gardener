import '../../../shared/models/recognition_result.dart';

abstract class HistoryRepository {
  Future<List<RecognitionResult>> getAll();

  Future<RecognitionResult> add(RecognitionResult result);
}
