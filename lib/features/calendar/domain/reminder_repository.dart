import 'care_reminder.dart';

abstract class ReminderRepository {
  Future<List<CareReminder>> getAll();

  Future<void> upsert(CareReminder reminder);
}
