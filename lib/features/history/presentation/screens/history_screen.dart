import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/utils/format_date.dart';
import '../../../../shared/widgets/empty_placeholder.dart';
import '../../../../shared/widgets/swipe_delete_background.dart';
import '../providers/history_providers.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(historyProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('История')),
      body: items.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const EmptyPlaceholder(
          icon: Icons.history,
          title: 'История не открылась',
          subtitle: 'Не удалось прочитать сохранённые распознавания.',
        ),
        data: (items) => items.isEmpty
            ? const EmptyPlaceholder(
                icon: Icons.history,
                title: 'Пока пусто',
                subtitle: 'Сфотографируйте растение. Результат сохранится на этом телефоне.',
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                itemCount: items.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = items[index];
                  final rowHeight = MediaQuery.textScalerOf(context).scale(76);
                  return Dismissible(
                    key: ValueKey(item.id),
                    direction: DismissDirection.endToStart,
                    background: const SwipeDeleteBackground(),
                    onDismissed: (_) {
                      ref.read(historyProvider.notifier).remove(item.id);
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: rowHeight,
                      child: Material(
                        color: theme.colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: theme.colorScheme.outlineVariant,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => context.push(
                            AppRoutes.recognitionResult,
                            extra: item,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  formatDateTime(item.createdAt),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
