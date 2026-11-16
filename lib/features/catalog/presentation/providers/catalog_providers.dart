import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/models/plant.dart';
import '../../data/datasources/plant_catalog_local_datasource.dart';
import '../../data/repositories/plant_catalog_repository_impl.dart';
import '../../domain/repositories/plant_catalog_repository.dart';

final plantCatalogRepositoryProvider = Provider<PlantCatalogRepository>((ref) {
  return const PlantCatalogRepositoryImpl(PlantCatalogLocalDataSource());
});

final plantsProvider = Provider<List<Plant>>((ref) {
  return ref.watch(plantCatalogRepositoryProvider).getAll();
});

final plantByIdProvider = Provider.family<Plant?, String>((ref, id) {
  return ref.watch(plantCatalogRepositoryProvider).findById(id);
});
