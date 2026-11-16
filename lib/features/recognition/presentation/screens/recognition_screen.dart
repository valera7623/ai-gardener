import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../shared/models/recognition_result.dart';
import '../../../settings/presentation/providers/app_settings_provider.dart';
import '../providers/recognition_providers.dart';
import '../widgets/photo_preview.dart';

class RecognitionScreen extends ConsumerWidget {
  const RecognitionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recognitionControllerProvider);
    final connectionReady = ref.watch(appSettingsProvider).connection.isReady;
    final theme = Theme.of(context);
    final canRecognize = state.hasImage && !state.isRecognizing;

    return Scaffold(
      appBar: AppBar(title: const Text('Распознавание')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              children: [
                PhotoPreview(imagePath: state.imagePath),
                const SizedBox(height: 16),
                Text(
                  'Сфотографируйте проблему крупно: лист, пятно или насекомое. Без интернета фото оценит модель на телефоне.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (state.result != null && state.result!.isOffline) ...[
                  const SizedBox(height: 16),
                  _OfflineMatches(result: state.result!),
                ],
                if (!connectionReady) ...[
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.push(AppRoutes.settings),
                    child: const Text('Настроить распознавание'),
                  ),
                ],
                if (state.errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    state.errorMessage!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Column(
              children: [
                OutlinedButton.icon(
                  onPressed: state.isRecognizing
                      ? null
                      : () => ref
                            .read(recognitionControllerProvider.notifier)
                            .pickFromCamera(),
                  icon: const Icon(Icons.photo_camera_outlined),
                  label: const Text('Сделать фото'),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: state.isRecognizing
                      ? null
                      : () => ref
                            .read(recognitionControllerProvider.notifier)
                            .pickFromGallery(),
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text('Выбрать из галереи'),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: canRecognize
                      ? () async {
                          final recognized = await ref
                              .read(recognitionControllerProvider.notifier)
                              .recognize();
                          final result = ref
                              .read(recognitionControllerProvider)
                              .result;
                          if (recognized &&
                              context.mounted &&
                              result != null &&
                              !result.isOffline) {
                            context.push(AppRoutes.recognitionResult);
                          }
                        }
                      : null,
                  child: state.isRecognizing
                      ? SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            color: theme.colorScheme.onPrimary,
                          ),
                        )
                      : const Text('Распознать'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OfflineMatches extends StatelessWidget {
  const _OfflineMatches({required this.result});

  final RecognitionResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final matches = result.matches;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Оценка на телефоне', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        for (var index = 0; index < matches.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 28,
                  child: Text(
                    '${index + 1}.',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Expanded(
                  child: Text(
                    matches[index].title,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                Text(
                  '${(matches[index].confidence * 100).round()}%',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        OutlinedButton(
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(result.title),
                content: const Text(
                  'Подробный разбор этой болезни появится позже.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Закрыть'),
                  ),
                ],
              ),
            );
          },
          child: const Text('Подробнее'),
        ),
      ],
    );
  }
}
