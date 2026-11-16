import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/database/app_database.dart';
import 'features/calendar/data/local_reminder_scheduler.dart';
import 'features/calendar/data/repositories/reminder_repository_impl.dart';
import 'features/calendar/domain/climate_zone.dart';
import 'features/calendar/domain/reminder_sync.dart';
import 'features/calendar/presentation/providers/reminder_providers.dart';
import 'features/recognition/domain/recognition_connection.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/app_settings.dart';
import 'features/settings/presentation/providers/app_settings_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    const endpoint = String.fromEnvironment('RECOGNITION_ENDPOINT');
    if (endpoint.startsWith('https://127.0.0.1') ||
        endpoint.startsWith('https://localhost')) {
      HttpOverrides.global = _LoopbackCertificateTrust();
    }
  }
  final isar = await openAppDatabase();
  final settings = _launchSettings(await SettingsRepositoryImpl(isar).read());
  final scheduler = LocalReminderScheduler();
  await scheduler.initialize();
  await ReminderSync(
    repository: ReminderRepositoryImpl(isar),
    scheduler: scheduler,
  ).rescheduleZone(zone: climateZoneById(settings.climateZoneId));

  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
        initialSettingsProvider.overrideWithValue(settings),
        reminderSchedulerProvider.overrideWithValue(scheduler),
      ],
      child: const AiGardenerApp(),
    ),
  );
}

class _LoopbackCertificateTrust extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback = (certificate, host, port) {
      return host == '127.0.0.1' || host == 'localhost';
    };
    return client;
  }
}

AppSettings _launchSettings(AppSettings settings) {
  const endpoint = String.fromEnvironment('RECOGNITION_ENDPOINT');
  if (endpoint.isEmpty) {
    return settings;
  }
  const clientKey = String.fromEnvironment('RECOGNITION_CLIENT_KEY');
  return settings.copyWith(
    connection: RecognitionConnection(
      backend: RecognitionBackend.custom,
      endpoint: endpoint,
      apiKey: clientKey,
    ),
  );
}
