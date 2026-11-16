abstract class ReminderScheduler {
  Future<bool> ensurePermission();

  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime when,
  });

  Future<void> cancel(int id);
}

class NoopReminderScheduler implements ReminderScheduler {
  const NoopReminderScheduler();

  @override
  Future<void> cancel(int id) async {}

  @override
  Future<bool> ensurePermission() async => true;

  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime when,
  }) async {}
}
