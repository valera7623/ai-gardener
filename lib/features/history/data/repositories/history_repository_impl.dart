import 'dart:io';

import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../shared/models/recognition_result.dart';
import '../../domain/history_repository.dart';
import '../isar/recognition_record.dart';
import '../isar/recognition_record_mapper.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl(this._isar, [this._photosDirectory]);

  final Isar _isar;
  final Directory? _photosDirectory;

  @override
  Future<RecognitionResult> add(RecognitionResult result) async {
    final imagePath = await _storePhoto(result.imagePath, result.id);
    final stored = RecognitionResult(
      id: result.id,
      title: result.title,
      summary: result.summary,
      confidence: result.confidence,
      recommendations: result.recommendations,
      createdAt: result.createdAt,
      plantId: result.plantId,
      imagePath: imagePath,
      isDemo: result.isDemo,
      isOffline: result.isOffline,
      matches: result.matches,
    );
    final record = recognitionRecordFromResult(stored);
    await _isar.writeTxn(() async {
      final existing = await _isar.recognitionRecords
          .filter()
          .resultIdEqualTo(stored.id)
          .findFirst();
      if (existing != null) {
        record.id = existing.id;
      }
      await _isar.recognitionRecords.put(record);
    });
    return stored;
  }

  @override
  Future<void> delete(String id) async {
    String? imagePath;
    await _isar.writeTxn(() async {
      final existing = await _isar.recognitionRecords
          .filter()
          .resultIdEqualTo(id)
          .findFirst();
      if (existing == null) {
        return;
      }
      imagePath = existing.imagePath;
      await _isar.recognitionRecords.delete(existing.id);
    });
    await _deleteStoredPhoto(imagePath);
  }

  @override
  Future<List<RecognitionResult>> getAll() async {
    final records = await _isar.recognitionRecords.where().findAll();
    records.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return [for (final record in records) recognitionResultFromRecord(record)];
  }

  Future<String?> _storePhoto(String? sourcePath, String resultId) async {
    if (sourcePath == null || sourcePath.isEmpty) {
      return null;
    }
    final source = File(sourcePath);
    if (!await source.exists()) {
      return sourcePath;
    }
    try {
      final folder = await _photoFolder();
      final safeId = resultId.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');
      final target = File('${folder.path}/$safeId.jpg');
      if (source.path == target.path) {
        return target.path;
      }
      return (await source.copy(target.path)).path;
    } catch (_) {
      return sourcePath;
    }
  }

  Future<void> _deleteStoredPhoto(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }
    final folder = await _photoFolder();
    final file = File(path);
    final folderPath = folder.absolute.path;
    final filePath = file.absolute.path;
    final insideFolder =
        filePath == folderPath ||
        filePath.startsWith('$folderPath${Platform.pathSeparator}');
    if (!insideFolder || !await file.exists()) {
      return;
    }
    await file.delete();
  }

  Future<Directory> _photoFolder() async {
    final override = _photosDirectory;
    final folder =
        override ??
        Directory(
          '${(await getApplicationSupportDirectory()).path}/recognition_photos',
        );
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }
    return folder;
  }
}
