import 'dart:io';

import '../../../../core/errors/app_exception.dart';
import '../../../../shared/models/recognition_result.dart';
import '../../../catalog/domain/repositories/plant_catalog_repository.dart';
import '../../domain/recognition_connection.dart';
import '../../domain/repositories/recognition_repository.dart';
import '../http_recognition_api.dart';
import '../recognition_image.dart';

class RecognitionRepositoryImpl implements RecognitionRepository {
  const RecognitionRepositoryImpl({
    required this.api,
    required this.catalog,
    required this.readConnection,
  });

  final HttpRecognitionApi api;
  final PlantCatalogRepository catalog;
  final RecognitionConnection Function() readConnection;

  @override
  Future<RecognitionResult> recognize({required String imagePath}) async {
    if (imagePath.trim().isEmpty) {
      throw const AppException('Сначала выберите фотографию.');
    }
    final file = File(imagePath);
    if (!await file.exists()) {
      throw const AppException(
        'Не удалось прочитать фото. Выберите его ещё раз.',
      );
    }

    final prepared = prepareRecognitionImage(await file.readAsBytes());
    final payload = await api.recognize(
      imageBytes: prepared.bytes,
      mimeType: prepared.mimeType ?? _mimeType(imagePath),
      connection: readConnection(),
      plants: catalog.getAll(),
    );
    final plantId = catalog.findById(payload.plantId ?? '') == null
        ? null
        : payload.plantId;

    return RecognitionResult(
      id: 'cloud-${DateTime.now().microsecondsSinceEpoch}',
      title: payload.title,
      summary: payload.summary,
      confidence: payload.confidence,
      recommendations: payload.recommendations,
      createdAt: DateTime.now(),
      plantId: plantId,
      imagePath: imagePath,
      isDemo: false,
    );
  }

  String _mimeType(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.png')) {
      return 'image/png';
    }
    if (lower.endsWith('.webp')) {
      return 'image/webp';
    }
    return 'image/jpeg';
  }
}
