import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/calendar/data/isar/reminder_record.dart';
import '../../features/history/data/isar/recognition_record.dart';
import '../../features/settings/data/isar/app_settings_record.dart';

final isarProvider = Provider<Isar>((ref) {
  throw StateError('Локальная база не открыта.');
});

Future<Isar> openAppDatabase({String? directory}) async {
  final path = directory ?? (await getApplicationSupportDirectory()).path;
  try {
    return await _openAt(path);
  } on IsarError catch (error) {
    if (!error.message.toLowerCase().contains('schema')) {
      rethrow;
    }
    await _deleteDatabaseFiles(path);
    return _openAt(path);
  }
}

Future<Isar> _openAt(String path) {
  return Isar.open(
    [RecognitionRecordSchema, AppSettingsRecordSchema, ReminderRecordSchema],
    directory: path,
    name: 'ai_gardener',
  );
}

Future<void> _deleteDatabaseFiles(String path) async {
  final directory = Directory(path);
  if (!await directory.exists()) {
    return;
  }
  await for (final entity in directory.list()) {
    if (entity is File &&
        entity.uri.pathSegments.last.startsWith('ai_gardener.isar')) {
      await entity.delete();
    }
  }
}
