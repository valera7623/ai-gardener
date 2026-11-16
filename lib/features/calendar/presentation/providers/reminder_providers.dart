import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../data/repositories/reminder_repository_impl.dart';
import '../../domain/care_reminder.dart';
import '../../domain/care_task.dart';
import '../../domain/climate_zone.dart';
import '../../domain/reminder_repository.dart';
import '../../domain/reminder_scheduler.dart';
import '../../domain/reminder_sync.dart';

final reminderRepositoryProvider = Provider<ReminderRepository>((ref) {
  return ReminderRepositoryImpl(ref.watch(isarProvider));
});

final reminderSchedulerProvider = Provider<ReminderScheduler>((ref) {
  return const NoopReminderScheduler();
});

final reminderSyncProvider = Provider<ReminderSync>((ref) {
  return ReminderSync(
    repository: ref.watch(reminderRepositoryProvider),
    scheduler: ref.watch(reminderSchedulerProvider),
  );
});

final reminderListProvider =
    AsyncNotifierProvider<ReminderController, List<CareReminder>>(
      ReminderController.new,
    );

class ReminderController extends AsyncNotifier<List<CareReminder>> {
  @override
  Future<List<CareReminder>> build() {
    return ref.read(reminderRepositoryProvider).getAll();
  }

  Future<String?> toggle({
    required CareTask task,
    required ClimateZone zone,
    required bool enabled,
  }) async {
    final message = await ref
        .read(reminderSyncProvider)
        .setEnabled(task: task, zone: zone, enabled: enabled);
    if (message != null) {
      return message;
    }
    state = AsyncData(await ref.read(reminderRepositoryProvider).getAll());
    return null;
  }
}
