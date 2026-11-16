import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../shared/widgets/entry_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            tooltip: 'Настройки',
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
        children: [
          Text('Здравствуйте', style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Сфотографируйте лист или откройте справочник — подскажем, что делать дальше.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          EntryCard(
            emphasized: true,
            icon: Icons.photo_camera_outlined,
            title: 'Сфотографировать растение',
            subtitle: 'Камера или снимок из галереи',
            onTap: () => context.push(AppRoutes.recognition),
          ),
          const SizedBox(height: 12),
          EntryCard(
            icon: Icons.menu_book_outlined,
            title: 'Справочник',
            subtitle: 'Комнатные и садовые, коротко и по делу',
            onTap: () => context.push(AppRoutes.catalog),
          ),
          const SizedBox(height: 12),
          EntryCard(
            icon: Icons.calendar_month_outlined,
            title: 'Календарь ухода',
            subtitle: 'Сроки работ с оглядкой на климат',
            onTap: () => context.push(AppRoutes.calendar),
          ),
          const SizedBox(height: 12),
          EntryCard(
            icon: Icons.history,
            title: 'История',
            subtitle: 'Ваши прошлые фото и выводы',
            onTap: () => context.push(AppRoutes.history),
          ),
        ],
      ),
    );
  }
}
