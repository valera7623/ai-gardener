import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../domain/reminder_scheduler.dart';

class LocalReminderScheduler implements ReminderScheduler {
  LocalReminderScheduler({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  var _zonesReady = false;

  Future<void> initialize() async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      return;
    }
    try {
      const settings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      );
      await _plugin.initialize(settings);
    } catch (error) {
      debugPrint('Уведомления не инициализированы: $error');
    }
  }

  @override
  Future<void> cancel(int id) async {
    if (!_canSchedule) {
      return;
    }
    try {
      await _plugin.cancel(id);
    } catch (error) {
      debugPrint('Не удалось отменить напоминание: $error');
    }
  }

  @override
  Future<bool> ensurePermission() async {
    if (!_canSchedule) {
      return false;
    }
    try {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      if (android != null) {
        return await android.requestNotificationsPermission() ?? false;
      }
      final ios = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      if (ios != null) {
        return await ios.requestPermissions(
              alert: true,
              badge: false,
              sound: true,
            ) ??
            false;
      }
      return false;
    } catch (error) {
      debugPrint('Разрешение на уведомления не получено: $error');
      return false;
    }
  }

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime when,
  }) async {
    if (!_canSchedule) {
      return;
    }
    try {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        _asLocal(when),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'care_reminders',
            'Напоминания по уходу',
            channelDescription:
                'Сезонные работы в саду и для комнатных растений',
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    } catch (error) {
      debugPrint('Напоминание не запланировано: $error');
    }
  }

  bool get _canSchedule => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  tz.TZDateTime _asLocal(DateTime when) {
    _ensureZones();
    final local = when.toLocal();
    return tz.TZDateTime(
      tz.local,
      local.year,
      local.month,
      local.day,
      local.hour,
      local.minute,
    );
  }

  void _ensureZones() {
    if (_zonesReady) {
      return;
    }
    tz_data.initializeTimeZones();
    final offset = DateTime.now().timeZoneOffset.inMilliseconds;
    final matches = tz.timeZoneDatabase.locations.values.where(
      (location) => location.currentTimeZone.offset == offset,
    );
    tz.setLocalLocation(matches.isEmpty ? tz.UTC : matches.first);
    _zonesReady = true;
  }
}
