import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../catalog/presentation/providers/catalog_providers.dart';
import '../../../history/presentation/providers/history_providers.dart';
import '../../../settings/presentation/providers/app_settings_provider.dart';
import '../../data/http_recognition_api.dart';
import '../../data/lookup_network_status.dart';
import '../../data/offline_diagnosis_service.dart';
import '../../data/on_device_plant_recognizer.dart';
import '../../data/repositories/offline_aware_recognition_repository.dart';
import '../../data/repositories/on_device_recognition_repository.dart';
import '../../data/repositories/recognition_repository_impl.dart';
import '../../domain/repositories/recognition_repository.dart';
import '../../domain/usecases/recognize_plant.dart';
import '../state/recognition_state.dart';

final recognitionHttpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
});

final offlineDiagnosisServiceProvider = Provider<OfflineDiagnosisService>((
  ref,
) {
  return OfflineDiagnosisService();
});

final onDevicePlantRecognizerProvider = Provider<OnDevicePlantRecognizer>((
  ref,
) {
  final recognizer = OnDevicePlantRecognizer(
    diagnoses: ref.watch(offlineDiagnosisServiceProvider),
  );
  ref.onDispose(recognizer.dispose);
  return recognizer;
});

final recognitionRepositoryProvider = Provider<RecognitionRepository>((ref) {
  return OfflineAwareRecognitionRepository(
    online: RecognitionRepositoryImpl(
      api: HttpRecognitionApi(ref.watch(recognitionHttpClientProvider)),
      catalog: ref.watch(plantCatalogRepositoryProvider),
      readConnection: () => ref.read(appSettingsProvider).connection,
    ),
    offline: OnDeviceRecognitionRepository(
      ref.watch(onDevicePlantRecognizerProvider),
    ),
    isOnline: const LookupNetworkStatus().isOnline,
  );
});

final recognizePlantProvider = Provider<RecognizePlant>((ref) {
  return RecognizePlant(ref.watch(recognitionRepositoryProvider));
});

final recognitionControllerProvider =
    NotifierProvider<RecognitionController, RecognitionState>(
      RecognitionController.new,
    );

class RecognitionController extends Notifier<RecognitionState> {
  @override
  RecognitionState build() => const RecognitionState();

  void clearPhoto() {
    state = state.copyWith(
      clearImage: true,
      clearResult: true,
      clearError: true,
    );
  }

  Future<void> pickFromCamera() => _pick(ImageSource.camera);

  Future<void> pickFromGallery() => _pick(ImageSource.gallery);

  Future<void> _pick(ImageSource source) async {
    try {
      final file = await ImagePicker().pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1600,
      );
      if (file == null) {
        return;
      }
      state = state.copyWith(
        imagePath: file.path,
        clearResult: true,
        clearError: true,
      );
    } catch (_) {
      state = state.copyWith(
        errorMessage:
            'Не удалось открыть фото. Проверьте доступ к камере или галерее.',
      );
    }
  }

  Future<bool> recognize() async {
    final imagePath = state.imagePath;
    if (imagePath == null || imagePath.isEmpty) {
      state = state.copyWith(errorMessage: 'Сначала выберите фотографию.');
      return false;
    }

    state = state.copyWith(isRecognizing: true, clearError: true);
    try {
      final result = await ref.read(recognizePlantProvider)(
        imagePath: imagePath,
      );
      final saved = await ref.read(historyProvider.notifier).add(result);
      state = state.copyWith(isRecognizing: false, result: saved);
      return true;
    } on AppException catch (error) {
      state = state.copyWith(isRecognizing: false, errorMessage: error.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        isRecognizing: false,
        errorMessage: 'Не получилось распознать фото. Попробуйте ещё раз.',
      );
      return false;
    }
  }
}
