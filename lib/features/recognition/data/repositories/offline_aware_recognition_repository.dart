import '../../../../shared/models/recognition_result.dart';
import '../../domain/repositories/recognition_repository.dart';

/// Облако используется только при сети. Модель на телефоне — только без сети.
class OfflineAwareRecognitionRepository implements RecognitionRepository {
  const OfflineAwareRecognitionRepository({
    required this.online,
    required this.offline,
    required this.isOnline,
  });

  final RecognitionRepository online;
  final RecognitionRepository offline;
  final Future<bool> Function() isOnline;

  @override
  Future<RecognitionResult> recognize({required String imagePath}) async {
    if (await isOnline()) {
      return online.recognize(imagePath: imagePath);
    }
    return offline.recognize(imagePath: imagePath);
  }
}
