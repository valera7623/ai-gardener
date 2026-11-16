import '../../../../shared/models/recognition_result.dart';

class RecognitionState {
  const RecognitionState({
    this.imagePath,
    this.isRecognizing = false,
    this.result,
    this.errorMessage,
  });

  final String? imagePath;
  final bool isRecognizing;
  final RecognitionResult? result;
  final String? errorMessage;

  bool get hasImage => imagePath != null && imagePath!.isNotEmpty;

  RecognitionState copyWith({
    String? imagePath,
    bool clearImage = false,
    bool? isRecognizing,
    RecognitionResult? result,
    bool clearResult = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return RecognitionState(
      imagePath: clearImage ? null : imagePath ?? this.imagePath,
      isRecognizing: isRecognizing ?? this.isRecognizing,
      result: clearResult ? null : result ?? this.result,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
