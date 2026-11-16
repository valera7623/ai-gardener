import 'package:isar_community/isar.dart';

part 'reminder_record.g.dart';

@collection
class ReminderRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String taskId;

  bool enabled = false;
  int notificationId = 0;
  late DateTime scheduledFor;
}
