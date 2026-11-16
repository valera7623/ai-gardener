class CareReminder {
  const CareReminder({
    required this.taskId,
    required this.enabled,
    required this.notificationId,
    required this.scheduledFor,
  });

  final String taskId;
  final bool enabled;
  final int notificationId;
  final DateTime scheduledFor;

  CareReminder copyWith({bool? enabled, DateTime? scheduledFor}) {
    return CareReminder(
      taskId: taskId,
      enabled: enabled ?? this.enabled,
      notificationId: notificationId,
      scheduledFor: scheduledFor ?? this.scheduledFor,
    );
  }
}
