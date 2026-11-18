import 'dart:ffi';
import 'dart:io';

import 'package:ai_gardener/core/database/app_database.dart';
import 'package:ai_gardener/features/calendar/data/repositories/reminder_repository_impl.dart';
import 'package:ai_gardener/features/calendar/domain/care_reminder.dart';
import 'package:ai_gardener/features/history/data/repositories/history_repository_impl.dart';
import 'package:ai_gardener/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:ai_gardener/features/recognition/domain/recognition_connection.dart';
import 'package:ai_gardener/features/settings/domain/app_settings.dart';
import 'package:ai_gardener/shared/models/care_recommendation.dart';
import 'package:ai_gardener/shared/models/recognition_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';

void main() {
  late Directory directory;
  late Isar isar;

  setUpAll(() async {
    final library =
        '${Platform.environment['HOME']}/.pub-cache/hosted/pub.dev/isar_community_flutter_libs-3.4.1/linux/libisar.so';
    await Isar.initializeIsarCore(libraries: {Abi.current(): library});
  });

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('ai_gardener_isar');
    isar = await openAppDatabase(directory: directory.path);
  });

  tearDown(() async {
    if (isar.isOpen) {
      await isar.close();
    }
    if (directory.existsSync()) {
      await directory.delete(recursive: true);
    }
  });

  test('theme, zone, history and reminders survive reopening', () async {
    await SettingsRepositoryImpl(isar).save(
      const AppSettings(
        themeMode: ThemeMode.dark,
        climateZoneId: 'siberia',
        connection: RecognitionConnection(
          backend: RecognitionBackend.custom,
          endpoint: 'https://garden.example.ru',
          apiKey: 'local-key',
        ),
      ),
    );
    final saved =
        await HistoryRepositoryImpl(
          isar,
          Directory('${directory.path}/photos'),
        ).add(
          RecognitionResult(
            id: 'leaf-1',
            title: 'Тля на розе',
            summary: 'Колония на молодых побегах.',
            confidence: 0.77,
            recommendations: const [
              CareRecommendation(
                title: 'Смыть колонию',
                description: 'Смойте тлю тёплой водой.',
                topic: CareTopic.general,
              ),
            ],
            createdAt: DateTime.utc(2026, 6, 1, 9),
          ),
        );
    await ReminderRepositoryImpl(isar).upsert(
      CareReminder(
        taskId: 'tomato-sow',
        enabled: true,
        notificationId: 1,
        scheduledFor: DateTime.utc(2026, 4, 8, 2),
      ),
    );

    expect(saved.title, 'Тля на розе');
    await isar.close();
    isar = await openAppDatabase(directory: directory.path);

    final settings = await SettingsRepositoryImpl(isar).read();
    final history = await HistoryRepositoryImpl(isar).getAll();
    final reminders = await ReminderRepositoryImpl(isar).getAll();

    expect(settings.themeMode, ThemeMode.dark);
    expect(settings.climateZoneId, 'siberia');
    expect(settings.connection.endpoint, RecognitionConnection.serviceEndpoint);
    expect(settings.connection.apiKey, RecognitionConnection.clientKey);
    expect(history.single.title, 'Тля на розе');
    expect(history.single.recommendations.single.topic, CareTopic.general);
    expect(reminders.single.taskId, 'tomato-sow');
    expect(reminders.single.enabled, isTrue);
  });

  test('deleting a history entry removes its stored photo', () async {
    final photos = Directory('${directory.path}/photos');
    final source = File('${directory.path}/leaf.jpg')
      ..writeAsStringSync('jpeg');
    final repository = HistoryRepositoryImpl(isar, photos);
    final saved = await repository.add(
      RecognitionResult(
        id: 'leaf-2',
        title: 'Пятно на листе',
        summary: 'Светлое пятно у края.',
        confidence: 0.4,
        recommendations: const [
          CareRecommendation(
            title: 'Свет',
            description: 'Уберите растение от прямого солнца.',
          ),
        ],
        createdAt: DateTime.utc(2026, 6, 2, 9),
        imagePath: source.path,
      ),
    );

    expect(File(saved.imagePath!).existsSync(), isTrue);

    await repository.delete(saved.id);

    expect(await repository.getAll(), isEmpty);
    expect(File(saved.imagePath!).existsSync(), isFalse);
    expect(source.existsSync(), isTrue);
  });
}
