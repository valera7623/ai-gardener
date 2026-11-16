import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../calendar/domain/climate_zone.dart';
import '../../../calendar/presentation/providers/reminder_providers.dart';
import '../../../recognition/domain/recognition_connection.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/app_settings.dart';
import '../../domain/settings_repository.dart';

final initialSettingsProvider = Provider<AppSettings>((ref) {
  return AppSettings.defaults;
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(ref.watch(isarProvider));
});

final appSettingsProvider =
    NotifierProvider<AppSettingsController, AppSettings>(
      AppSettingsController.new,
    );

final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(appSettingsProvider).themeMode;
});

class AppSettingsController extends Notifier<AppSettings> {
  @override
  AppSettings build() => ref.watch(initialSettingsProvider);

  Future<void> setTheme(ThemeMode mode) async {
    if (state.themeMode == mode) {
      return;
    }
    final next = state.copyWith(themeMode: mode);
    state = next;
    await ref.read(settingsRepositoryProvider).save(next);
  }

  Future<void> setClimateZone(String zoneId) async {
    final zone = climateZoneById(zoneId);
    if (state.climateZoneId == zone.id) {
      return;
    }
    final next = state.copyWith(climateZoneId: zone.id);
    state = next;
    await ref.read(settingsRepositoryProvider).save(next);
    await ref.read(reminderSyncProvider).rescheduleZone(zone: zone);
  }

  Future<void> setRecognition(RecognitionConnection connection) async {
    final next = state.copyWith(connection: connection);
    state = next;
    await ref.read(settingsRepositoryProvider).save(next);
  }
}
