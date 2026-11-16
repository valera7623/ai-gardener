import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../shared/models/plant.dart';
import '../providers/catalog_providers.dart';

enum _CatalogFilter { all, indoor, garden }

class CatalogScreen extends ConsumerStatefulWidget {
  const CatalogScreen({super.key});

  @override
  ConsumerState<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends ConsumerState<CatalogScreen> {
  final _searchController = TextEditingController();
  _CatalogFilter _filter = _CatalogFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plants = ref.watch(plantsProvider);
    final query = _searchController.text.trim().toLowerCase();
    final visible = plants.where((plant) {
      final matchesFilter = switch (_filter) {
        _CatalogFilter.all => true,
        _CatalogFilter.indoor => plant.category == PlantCategory.indoor,
        _CatalogFilter.garden => plant.category == PlantCategory.garden,
      };
      if (!matchesFilter) {
        return false;
      }
      if (query.isEmpty) {
        return true;
      }
      return plant.name.toLowerCase().contains(query) ||
          plant.latinName.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Справочник')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                hintText: 'Найти растение',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _FilterChip(
                  label: 'Все',
                  selected: _filter == _CatalogFilter.all,
                  onSelected: () =>
                      setState(() => _filter = _CatalogFilter.all),
                ),
                _FilterChip(
                  label: 'Комнатные',
                  selected: _filter == _CatalogFilter.indoor,
                  onSelected: () =>
                      setState(() => _filter = _CatalogFilter.indoor),
                ),
                _FilterChip(
                  label: 'Садовые',
                  selected: _filter == _CatalogFilter.garden,
                  onSelected: () =>
                      setState(() => _filter = _CatalogFilter.garden),
                ),
              ],
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? const Center(
                    child: Text('Ничего не нашли. Попробуйте другое название.'),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    itemCount: visible.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final plant = visible[index];
                      return _PlantTile(plant: plant);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
      ),
    );
  }
}

class _PlantTile extends StatelessWidget {
  const _PlantTile({required this.plant});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(AppRoutes.plantPath(plant.id)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(plant.name, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(
                      plant.latinName,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Text(
                    plant.category.label,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
