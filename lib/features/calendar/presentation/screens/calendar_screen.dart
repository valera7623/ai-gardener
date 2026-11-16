import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/format_date.dart';
import '../../../../shared/widgets/empty_placeholder.dart';
import '../../../settings/presentation/providers/app_settings_provider.dart';
import '../../domain/care_reminder.dart';
import '../../domain/care_schedule.dart';
import '../../domain/care_task.dart';
import '../../domain/climate_zone.dart';
import '../providers/reminder_providers.dart';
import '../widgets/climate_zone_tiles.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final zone = climateZoneById(settings.climateZoneId);
    final reminders = ref.watch(reminderListProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Календарь ухода')),
      body: reminders.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const EmptyPlaceholder(
          icon: Icons.event_busy,
          title: 'Календарь не открылся',
          subtitle: 'Не удалось прочитать сохранённые напоминания.',
        ),
        data: (items) {
          final tasks = upcomingCareTasks(zone: zone, now: DateTime.now());
          final children = <Widget>[
            Material(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => _showZoneSheet(context, ref),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              zone.name,
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              zone.regions,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.expand_more,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Сроки сдвинуты под выбранную зону. Это ориентир, а не прогноз погоды. Напоминание придёт около 9:00.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
          ];
          CareSeason? previousSeason;
          for (final scheduled in tasks) {
            if (scheduled.season != previousSeason) {
              if (previousSeason != null) {
                children.add(const SizedBox(height: 8));
              }
              children
                ..add(
                  Text(
                    scheduled.season.label,
                    style: theme.textTheme.titleLarge,
                  ),
                )
                ..add(const SizedBox(height: 8));
              previousSeason = scheduled.season;
            }
            children
              ..add(
                _CareTaskTile(
                  task: scheduled.task,
                  dateLabel: formatCareDate(scheduled.date),
                  enabled: _isEnabled(items, scheduled.task.id),
                  zone: zone,
                ),
              )
              ..add(const SizedBox(height: 10));
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: children,
          );
        },
      ),
    );
  }

  Future<void> _showZoneSheet(BuildContext context, WidgetRef ref) {
    final selectedId = ref.read(appSettingsProvider).climateZoneId;
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        final height = MediaQuery.sizeOf(context).height * 0.72;
        return SafeArea(
          child: SizedBox(
            height: height,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              children: [
                Text(
                  'Климатическая зона',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                ClimateZoneTiles(
                  selectedId: selectedId,
                  onSelected: (zoneId) async {
                    Navigator.of(context).pop();
                    await ref
                        .read(appSettingsProvider.notifier)
                        .setClimateZone(zoneId);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

bool _isEnabled(List<CareReminder> reminders, String taskId) {
  for (final reminder in reminders) {
    if (reminder.taskId == taskId) {
      return reminder.enabled;
    }
  }
  return false;
}

class _CareTaskTile extends ConsumerStatefulWidget {
  const _CareTaskTile({
    required this.task,
    required this.dateLabel,
    required this.enabled,
    required this.zone,
  });

  final CareTask task;
  final String dateLabel;
  final bool enabled;
  final ClimateZone zone;

  @override
  ConsumerState<_CareTaskTile> createState() => _CareTaskTileState();
}

class _CareTaskTileState extends ConsumerState<_CareTaskTile> {
  var _busy = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dateLabel,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: scheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(widget.task.title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    widget.task.detail,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: widget.enabled,
              onChanged: _busy
                  ? null
                  : (enabled) async {
                      setState(() => _busy = true);
                      final message = await ref
                          .read(reminderListProvider.notifier)
                          .toggle(
                            task: widget.task,
                            zone: widget.zone,
                            enabled: enabled,
                          );
                      if (!context.mounted) {
                        return;
                      }
                      setState(() => _busy = false);
                      if (message != null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(message)));
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
