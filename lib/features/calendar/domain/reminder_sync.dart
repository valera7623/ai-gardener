import 'care_reminder.dart';
import 'care_task.dart';
import 'care_schedule.dart';
import 'climate_zone.dart';
import 'reminder_repository.dart';
import 'reminder_scheduler.dart';

class ReminderSync {
  const ReminderSync({required this.repository, required this.scheduler});

  final ReminderRepository repository;
  final ReminderScheduler scheduler;

  Future<String?> setEnabled({
    required CareTask task,
    required ClimateZone zone,
    required bool enabled,
    DateTime? now,
  }) async {
    final clock = now ?? DateTime.now();
    final when = nextCareDate(task: task, zone: zone, now: clock);
    if (!enabled) {
      await scheduler.cancel(task.notificationId);
      await repository.upsert(
        CareReminder(
          taskId: task.id,
          enabled: false,
          notificationId: task.notificationId,
          scheduledFor: when,
        ),
      );
      return null;
    }

    final allowed = await scheduler.ensurePermission();
    if (!allowed) {
      return 'Разрешите уведомления, чтобы получать напоминания.';
    }

    await _schedule(task, zone, when);
    await repository.upsert(
      CareReminder(
        taskId: task.id,
        enabled: true,
        notificationId: task.notificationId,
        scheduledFor: when,
      ),
    );
    return null;
  }

  Future<void> rescheduleZone({
    required ClimateZone zone,
    DateTime? now,
  }) async {
    final clock = now ?? DateTime.now();
    final stored = await repository.getAll();
    for (final reminder in stored.where((item) => item.enabled)) {
      final task = careTaskById(reminder.taskId);
      if (task == null) {
        await scheduler.cancel(reminder.notificationId);
        continue;
      }
      final when = nextCareDate(task: task, zone: zone, now: clock);
      await _schedule(task, zone, when);
      await repository.upsert(reminder.copyWith(scheduledFor: when));
    }
  }

  Future<void> _schedule(CareTask task, ClimateZone zone, DateTime when) {
    return scheduler.schedule(
      id: task.notificationId,
      title: task.title,
      body: 'Зона «${zone.name}». ${task.detail}',
      when: when,
    );
  }
}
