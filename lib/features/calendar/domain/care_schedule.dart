import 'care_task.dart';
import 'climate_zone.dart';

enum CareSeason { spring, summer, autumn, winter }

extension CareSeasonLabel on CareSeason {
  String get label => switch (this) {
    CareSeason.spring => 'Весна',
    CareSeason.summer => 'Лето',
    CareSeason.autumn => 'Осень',
    CareSeason.winter => 'Зима',
  };
}

class ScheduledCareTask {
  const ScheduledCareTask({required this.task, required this.date});

  final CareTask task;
  final DateTime date;

  CareSeason get season => seasonOf(date);
}

CareSeason seasonOf(DateTime date) {
  return switch (date.month) {
    3 || 4 || 5 => CareSeason.spring,
    6 || 7 || 8 => CareSeason.summer,
    9 || 10 || 11 => CareSeason.autumn,
    _ => CareSeason.winter,
  };
}

DateTime nextCareDate({
  required CareTask task,
  required ClimateZone zone,
  required DateTime now,
}) {
  DateTime occurrence(int year) {
    return DateTime(
      year,
      task.month,
      task.day,
      9,
    ).add(Duration(days: zone.dayShift));
  }

  final current = occurrence(now.year);
  if (current.isBefore(now)) {
    return occurrence(now.year + 1);
  }
  return current;
}

List<ScheduledCareTask> upcomingCareTasks({
  required ClimateZone zone,
  required DateTime now,
}) {
  final tasks = [
    for (final task in careTasks)
      ScheduledCareTask(
        task: task,
        date: nextCareDate(task: task, zone: zone, now: now),
      ),
  ];
  tasks.sort((a, b) => a.date.compareTo(b.date));
  return tasks;
}
