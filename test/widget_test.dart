import 'package:ai_gardener/app.dart';
import 'package:ai_gardener/features/calendar/domain/care_reminder.dart';
import 'package:ai_gardener/features/calendar/domain/reminder_repository.dart';
import 'package:ai_gardener/features/calendar/presentation/providers/reminder_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('home shows the main entries', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: AiGardenerApp()));
    await tester.pumpAndSettle();

    expect(find.text('ИИ-садовник'), findsOneWidget);
    expect(find.text('Сфотографировать растение'), findsOneWidget);
    expect(find.text('Справочник'), findsOneWidget);
    expect(find.text('Календарь ухода'), findsOneWidget);
    expect(find.text('История'), findsOneWidget);
  });

  testWidgets('settings open the data policy', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: AiGardenerApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Настройки'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byKey(const Key('open-data-policy')),
      200,
    );
    await tester.tap(find.byKey(const Key('open-data-policy')));
    await tester.pumpAndSettle();

    expect(find.text('Кто обрабатывает данные'), findsOneWidget);
    expect(find.textContaining('https://aegisai.fun'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Ограничение'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.textContaining('не является диагнозом'), findsOneWidget);
  });

  testWidgets('catalog opens the plant list', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: AiGardenerApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Справочник'));
    await tester.pumpAndSettle();

    expect(find.text('Фикус Бенджамина'), findsOneWidget);
    expect(find.text('Монстера'), findsOneWidget);
  });

  testWidgets('calendar shows the selected climate zone', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          reminderRepositoryProvider.overrideWithValue(_MemoryReminders()),
        ],
        child: const AiGardenerApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Календарь ухода'));
    await tester.pumpAndSettle();

    expect(find.text('Средняя полоса'), findsOneWidget);
    expect(
      find.text('Посейте томаты на рассаду', skipOffstage: false),
      findsOneWidget,
    );

    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();

    expect(tester.widget<Switch>(find.byType(Switch).first).value, isTrue);
  });
}

class _MemoryReminders implements ReminderRepository {
  final _items = <String, CareReminder>{};

  @override
  Future<List<CareReminder>> getAll() async => _items.values.toList();

  @override
  Future<void> upsert(CareReminder reminder) async {
    _items[reminder.taskId] = reminder;
  }
}
