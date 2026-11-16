import 'package:ai_gardener/features/calendar/domain/care_schedule.dart';
import 'package:ai_gardener/features/calendar/domain/care_task.dart';
import 'package:ai_gardener/features/calendar/domain/climate_zone.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tomato = careTaskById('tomato-sow')!;
  final now = DateTime(2026, 1, 1, 8);

  test('center keeps the base date', () {
    final date = nextCareDate(
      task: tomato,
      zone: climateZoneById('center'),
      now: now,
    );

    expect(date, DateTime(2026, 3, 15, 9));
  });

  test('south moves spring work earlier', () {
    final date = nextCareDate(
      task: tomato,
      zone: climateZoneById('south'),
      now: now,
    );

    expect(date, DateTime(2026, 2, 18, 9));
  });

  test('a passed date is scheduled for the next year', () {
    final date = nextCareDate(
      task: tomato,
      zone: climateZoneById('center'),
      now: DateTime(2026, 11, 15, 12),
    );

    expect(date, DateTime(2027, 3, 15, 9));
  });

  test('upcoming tasks are sorted by the next date', () {
    final tasks = upcomingCareTasks(
      zone: climateZoneById('center'),
      now: DateTime(2026, 11, 15, 12),
    );

    expect(tasks.first.task.id, 'cold-window');
    expect(tasks.first.date.isBefore(tasks.last.date), isTrue);
  });
}
