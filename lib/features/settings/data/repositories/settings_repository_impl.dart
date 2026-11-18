import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';

import '../../../calendar/domain/climate_zone.dart';
import '../../../recognition/domain/recognition_connection.dart';
import '../../domain/app_settings.dart';
import '../../domain/settings_repository.dart';
import '../isar/app_settings_record.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._isar);

  final Isar _isar;

  @override
  Future<AppSettings> read() async {
    final record = await _isar.appSettingsRecords.get(1);
    if (record == null) {
      return AppSettings.defaults;
    }
    return AppSettings(
      themeMode: _themeMode(record.themeMode),
      climateZoneId: climateZoneById(record.climateZoneId).id,
    );
  }

  @override
  Future<void> save(AppSettings settings) {
    return _isar.writeTxn(() async {
      await _isar.appSettingsRecords.put(
        AppSettingsRecord()
          ..id = 1
          ..themeMode = settings.themeMode.name
          ..climateZoneId = settings.climateZoneId
          ..recognitionBackend = RecognitionConnection.defaults.backend.name
          ..recognitionApiKey = RecognitionConnection.defaults.apiKey
          ..recognitionEndpoint = RecognitionConnection.defaults.endpoint
          ..recognitionModel = RecognitionConnection.defaults.model
          ..recognitionFolderId = RecognitionConnection.defaults.folderId,
      );
    });
  }

  ThemeMode _themeMode(String name) {
    for (final mode in ThemeMode.values) {
      if (mode.name == name) {
        return mode;
      }
    }
    return ThemeMode.system;
  }
}
