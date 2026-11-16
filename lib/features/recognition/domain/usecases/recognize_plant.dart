import '../../../../shared/models/recognition_result.dart';
import '../repositories/recognition_repository.dart';

class RecognizePlant {
  const RecognizePlant(this._repository);

  final RecognitionRepository _repository;

  Future<RecognitionResult> call({required String imagePath}) {
    return _repository.recognize(imagePath: imagePath);
  }
}
