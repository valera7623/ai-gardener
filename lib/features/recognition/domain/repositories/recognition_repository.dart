import '../../../../shared/models/recognition_result.dart';

abstract class RecognitionRepository {
  Future<RecognitionResult> recognize({required String imagePath});
}
