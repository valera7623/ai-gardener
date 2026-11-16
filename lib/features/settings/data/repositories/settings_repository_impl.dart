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
      connection: _connection(record),
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
          ..recognitionBackend = settings.connection.backend.name
          ..recognitionApiKey = settings.connection.apiKey
          ..recognitionEndpoint = settings.connection.endpoint
          ..recognitionModel = settings.connection.model
          ..recognitionFolderId = settings.connection.folderId,
      );
    });
  }

  RecognitionConnection _connection(AppSettingsRecord record) {
    return RecognitionConnection(
      backend: _backend(record.recognitionBackend),
      apiKey: record.recognitionApiKey,
      endpoint: record.recognitionEndpoint,
      model: record.recognitionModel.trim().isEmpty
          ? RecognitionConnection.defaultModel
          : record.recognitionModel,
      folderId: record.recognitionFolderId,
    );
  }

  RecognitionBackend _backend(String name) {
    for (final backend in RecognitionBackend.values) {
      if (backend.name == name) {
        return backend;
      }
    }
    return RecognitionBackend.yandex;
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
