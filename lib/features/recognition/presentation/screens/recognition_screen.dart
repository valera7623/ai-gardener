import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../shared/widgets/swipe_delete_background.dart';
import '../providers/recognition_providers.dart';
import '../widgets/photo_preview.dart';

class RecognitionScreen extends ConsumerWidget {
  const RecognitionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recognitionControllerProvider);
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
                if (state.imagePath == null)
                  const PhotoPreview()
                else
                  Dismissible(
                    key: ValueKey(state.imagePath),
                    direction: state.isRecognizing
                        ? DismissDirection.none
                        : DismissDirection.endToStart,
                    background: const SwipeDeleteBackground(borderRadius: 20),
                    onDismissed: (_) {
                      ref
                          .read(recognitionControllerProvider.notifier)
                          .clearPhoto();
                    },
                    child: PhotoPreview(imagePath: state.imagePath),
                  ),
                const SizedBox(height: 16),
                Text(
                  'Сфотографируйте проблему крупно: лист, пятно или насекомое. Без интернета фото оценит модель на телефоне.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
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
                          if (recognized && context.mounted && result != null) {
                            context.push(
                              AppRoutes.recognitionResult,
                              extra: result,
                            );
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
