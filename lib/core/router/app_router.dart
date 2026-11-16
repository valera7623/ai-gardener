import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/catalog/presentation/screens/catalog_screen.dart';
import '../../features/catalog/presentation/screens/plant_detail_screen.dart';
import '../../features/history/presentation/screens/history_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/recognition/presentation/screens/recognition_result_screen.dart';
import '../../features/recognition/presentation/screens/recognition_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../shared/models/recognition_result.dart';
import '../../shared/widgets/empty_placeholder.dart';
import 'app_routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.recognition,
        builder: (context, state) => const RecognitionScreen(),
      ),
      GoRoute(
        path: AppRoutes.recognitionResult,
        builder: (context, state) {
          final extra = state.extra;
          return RecognitionResultScreen(
            result: extra is RecognitionResult ? extra : null,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.catalog,
        builder: (context, state) => const CatalogScreen(),
      ),
      GoRoute(
        path: AppRoutes.plant,
        builder: (context, state) {
          final plantId = state.pathParameters['plantId'] ?? '';
          return PlantDetailScreen(plantId: plantId);
        },
      ),
      GoRoute(
        path: AppRoutes.calendar,
        builder: (context, state) => const CalendarScreen(),
      ),
      GoRoute(
        path: AppRoutes.history,
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text('Страница не найдена')),
        body: EmptyPlaceholder(
          icon: Icons.error_outline,
          title: 'Такой страницы нет',
          subtitle: 'Вернитесь на главный экран.',
          action: FilledButton(
            onPressed: () => context.go(AppRoutes.home),
            child: const Text('На главную'),
          ),
        ),
      );
    },
  );
});
