import 'package:isar_community/isar.dart';

import '../../domain/care_reminder.dart';
import '../../domain/reminder_repository.dart';
import '../isar/reminder_record.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  const ReminderRepositoryImpl(this._isar);

  final Isar _isar;

  @override
  Future<List<CareReminder>> getAll() async {
    final records = await _isar.reminderRecords.where().findAll();
    return [for (final record in records) _toReminder(record)];
  }

  @override
  Future<void> upsert(CareReminder reminder) {
    return _isar.writeTxn(() async {
      final existing = await _isar.reminderRecords
          .filter()
          .taskIdEqualTo(reminder.taskId)
          .findFirst();
      final record = ReminderRecord()
        ..id = existing?.id ?? Isar.autoIncrement
        ..taskId = reminder.taskId
        ..enabled = reminder.enabled
        ..notificationId = reminder.notificationId
        ..scheduledFor = reminder.scheduledFor;
      await _isar.reminderRecords.put(record);
    });
  }

  CareReminder _toReminder(ReminderRecord record) {
    return CareReminder(
      taskId: record.taskId,
      enabled: record.enabled,
      notificationId: record.notificationId,
      scheduledFor: record.scheduledFor,
    );
  }
}
