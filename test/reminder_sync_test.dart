import 'package:ai_gardener/features/calendar/domain/care_reminder.dart';
import 'package:ai_gardener/features/calendar/domain/care_task.dart';
import 'package:ai_gardener/features/calendar/domain/climate_zone.dart';
import 'package:ai_gardener/features/calendar/domain/reminder_repository.dart';
import 'package:ai_gardener/features/calendar/domain/reminder_scheduler.dart';
import 'package:ai_gardener/features/calendar/domain/reminder_sync.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('enabling a reminder stores the shifted date', () async {
    final repository = _MemoryReminders();
    final scheduler = _RecordingScheduler();
    final sync = ReminderSync(repository: repository, scheduler: scheduler);
    final task = careTaskById('tomato-sow')!;

    final message = await sync.setEnabled(
      task: task,
      zone: climateZoneById('siberia'),
      enabled: true,
      now: DateTime(2026, 1, 1, 8),
    );

    expect(message, isNull);
    expect(scheduler.scheduled[task.notificationId], DateTime(2026, 4, 8, 9));
    expect(repository.items.values.single.enabled, isTrue);
  });

  test('changing the zone reschedules an enabled reminder', () async {
    final repository = _MemoryReminders();
    final scheduler = _RecordingScheduler();
    final sync = ReminderSync(repository: repository, scheduler: scheduler);
    final task = careTaskById('tomato-sow')!;

    await sync.setEnabled(
      task: task,
      zone: climateZoneById('center'),
      enabled: true,
      now: DateTime(2026, 1, 1, 8),
    );
    await sync.rescheduleZone(
      zone: climateZoneById('south'),
      now: DateTime(2026, 1, 1, 8),
    );

    expect(scheduler.scheduled[task.notificationId], DateTime(2026, 2, 18, 9));
  });

  test('denied permission does not enable the reminder', () async {
    final repository = _MemoryReminders();
    final scheduler = _RecordingScheduler()..allow = false;
    final sync = ReminderSync(repository: repository, scheduler: scheduler);

    final message = await sync.setEnabled(
      task: careTaskById('tomato-sow')!,
      zone: climateZoneById('center'),
      enabled: true,
    );

    expect(message, isNotNull);
    expect(repository.items, isEmpty);
    expect(scheduler.scheduled, isEmpty);
  });
}

class _MemoryReminders implements ReminderRepository {
  final items = <String, CareReminder>{};

  @override
  Future<List<CareReminder>> getAll() async => items.values.toList();

  @override
  Future<void> upsert(CareReminder reminder) async {
    items[reminder.taskId] = reminder;
  }
}

class _RecordingScheduler implements ReminderScheduler {
  final scheduled = <int, DateTime>{};
  var allow = true;

  @override
  Future<void> cancel(int id) async {
    scheduled.remove(id);
  }

  @override
  Future<bool> ensurePermission() async => allow;

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime when,
  }) async {
    scheduled[id] = when;
  }
}
