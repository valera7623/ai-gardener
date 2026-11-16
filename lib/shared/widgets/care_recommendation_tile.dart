import 'package:flutter/material.dart';

import '../models/care_recommendation.dart';

class CareRecommendationTile extends StatelessWidget {
  const CareRecommendationTile({required this.recommendation, super.key});

  final CareRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(_iconFor(recommendation.topic), color: scheme.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recommendation.title,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      recommendation.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconFor(CareTopic topic) {
    return switch (topic) {
      CareTopic.watering => Icons.water_drop_outlined,
      CareTopic.light => Icons.wb_sunny_outlined,
      CareTopic.temperature => Icons.thermostat_outlined,
      CareTopic.feeding => Icons.spa_outlined,
      CareTopic.pruning => Icons.content_cut,
      CareTopic.planting => Icons.yard_outlined,
      CareTopic.general => Icons.tips_and_updates_outlined,
    };
  }
}
