import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../calendar/presentation/widgets/climate_zone_tiles.dart';
import '../providers/app_settings_provider.dart';
import '../widgets/recognition_connection_form.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          Text('Оформление', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Тема сохранится на этом телефоне.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          _ThemeOption(
            title: 'Как в системе',
            icon: Icons.brightness_auto,
            selected: settings.themeMode == ThemeMode.system,
            onTap: () => ref
                .read(appSettingsProvider.notifier)
                .setTheme(ThemeMode.system),
          ),
          _ThemeOption(
            title: 'Светлая',
            icon: Icons.light_mode_outlined,
            selected: settings.themeMode == ThemeMode.light,
            onTap: () => ref
                .read(appSettingsProvider.notifier)
                .setTheme(ThemeMode.light),
          ),
          _ThemeOption(
            title: 'Тёмная',
            icon: Icons.dark_mode_outlined,
            selected: settings.themeMode == ThemeMode.dark,
            onTap: () =>
                ref.read(appSettingsProvider.notifier).setTheme(ThemeMode.dark),
          ),
          const SizedBox(height: 24),
          Text('Климатическая зона', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'От неё зависят сроки в календаре и дата напоминания.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          ClimateZoneTiles(
            selectedId: settings.climateZoneId,
            onSelected: (zoneId) {
              ref.read(appSettingsProvider.notifier).setClimateZone(zoneId);
            },
          ),
          const SizedBox(height: 16),
          Text('Распознавание', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Для публикации укажите свой сервер: ключ Yandex задаётся только на нём. В телефон можно ввести отдельный ключ доступа к серверу.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          const RecognitionConnectionForm(),
          const SizedBox(height: 16),
          Text('О приложении', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            '${AppConstants.appName} помогает заметить проблему по фото и подсказывает, как ухаживать за растением. Справочник, история и напоминания работают без интернета.',
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: selected ? scheme.primaryContainer : scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: selected ? scheme.primary : scheme.outlineVariant,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: selected ? scheme.onPrimaryContainer : scheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: selected
                          ? scheme.onPrimaryContainer
                          : scheme.onSurface,
                    ),
                  ),
                ),
                if (selected)
                  Icon(Icons.check, color: scheme.onPrimaryContainer),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
