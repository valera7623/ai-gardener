import 'package:flutter/material.dart';

import '../../domain/climate_zone.dart';

class ClimateZoneTiles extends StatelessWidget {
  const ClimateZoneTiles({
    required this.selectedId,
    required this.onSelected,
    super.key,
  });

  final String selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final zone in climateZones)
          _ZoneTile(
            zone: zone,
            selected: zone.id == selectedId,
            onTap: () => onSelected(zone.id),
          ),
      ],
    );
  }
}

class _ZoneTile extends StatelessWidget {
  const _ZoneTile({
    required this.zone,
    required this.selected,
    required this.onTap,
  });

  final ClimateZone zone;
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        zone.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: selected
                                  ? scheme.onPrimaryContainer
                                  : scheme.onSurface,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        zone.regions,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: selected
                              ? scheme.onPrimaryContainer
                              : scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
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
