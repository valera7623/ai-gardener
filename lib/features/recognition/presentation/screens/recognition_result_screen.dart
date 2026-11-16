import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../shared/models/recognition_result.dart';
import '../../../../shared/widgets/care_recommendation_tile.dart';
import '../../../../shared/widgets/empty_placeholder.dart';
import '../providers/recognition_providers.dart';
import '../widgets/photo_preview.dart';

class RecognitionResultScreen extends ConsumerWidget {
  const RecognitionResultScreen({this.result, super.key});

  final RecognitionResult? result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resolved = result ?? ref.watch(recognitionControllerProvider).result;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Результат')),
      body: resolved == null
          ? EmptyPlaceholder(
              icon: Icons.image_search_outlined,
              title: 'Результата пока нет',
              subtitle: 'Сначала выберите фото и нажмите «Распознать».',
              action: FilledButton(
                onPressed: () => context.go(AppRoutes.recognition),
                child: const Text('К распознаванию'),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: resolved.isDemo
                        ? theme.colorScheme.secondaryContainer
                        : theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Text(
                      resolved.isDemo
                          ? 'Это сохранённый учебный пример, а не ответ сервиса.'
                          : resolved.isOffline
                          ? 'Оценка сделана на телефоне без интернета. Сверьте её с листом.'
                          : 'Сверьтесь с растением: облачная подсказка может ошибиться.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: resolved.isDemo
                            ? theme.colorScheme.onSecondaryContainer
                            : theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                PhotoPreview(imagePath: resolved.imagePath),
                const SizedBox(height: 20),
                Text(resolved.title, style: theme.textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(
                  'Похожесть: ${(resolved.confidence * 100).round()}%',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(resolved.summary, style: theme.textTheme.bodyLarge),
                const SizedBox(height: 20),
                Text('Что сделать', style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                for (final recommendation in resolved.recommendations)
                  CareRecommendationTile(recommendation: recommendation),
                if (resolved.plantId != null) ...[
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () =>
                        context.push(AppRoutes.plantPath(resolved.plantId!)),
                    child: const Text('Открыть карточку растения'),
                  ),
                ],
              ],
            ),
    );
  }
}
