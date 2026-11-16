import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/care_recommendation_tile.dart';
import '../../../../shared/widgets/empty_placeholder.dart';
import '../providers/catalog_providers.dart';

class PlantDetailScreen extends ConsumerWidget {
  const PlantDetailScreen({required this.plantId, super.key});

  final String plantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plant = ref.watch(plantByIdProvider(plantId));
    final theme = Theme.of(context);

    if (plant == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Растение')),
        body: const EmptyPlaceholder(
          icon: Icons.search_off,
          title: 'Не нашли такое растение',
          subtitle: 'Вернитесь в справочник и выберите карточку из списка.',
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(plant.name)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          Text(
            plant.latinName,
            style: theme.textTheme.titleMedium?.copyWith(
              fontStyle: FontStyle.italic,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Text(
                  plant.category.label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(plant.summary, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 24),
          Text('Как ухаживать', style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
          for (final recommendation in plant.care)
            CareRecommendationTile(recommendation: recommendation),
          if (plant.commonProblems.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text('На что смотреть', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            for (final problem in plant.commonProblems)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(problem, style: theme.textTheme.bodyLarge),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}
