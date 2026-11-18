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
                if (resolved.isOnDeviceAssessment) ...[
                  const Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _ResultMark('Оценка на устройстве'),
                      _ResultMark('Без интернета'),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
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
                          : resolved.isOnDeviceAssessment
                          ? 'Сверьте оценку с листом: модель на телефоне может ошибиться.'
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
                  resolved.isOnDeviceAssessment
                      ? 'Уверенность модели: ${(resolved.confidence * 100).round()}%'
                      : 'Похожесть: ${(resolved.confidence * 100).round()}%',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                if (resolved.isOnDeviceAssessment &&
                    resolved.confidence < 0.5) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Модель не уверена, лучше сделать фото при хорошем освещении или использовать онлайн-режим',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Text(resolved.summary, style: theme.textTheme.bodyLarge),
                if (resolved.matches.length > 1) ...[
                  const SizedBox(height: 16),
                  Text('Другие варианты', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  for (final match in resolved.matches.skip(1))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        '${match.title} · ${(match.confidence * 100).round()}%',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                ],
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

class _ResultMark extends StatelessWidget {
  const _ResultMark(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(
          text,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSecondaryContainer,
          ),
        ),
      ),
    );
  }
}
