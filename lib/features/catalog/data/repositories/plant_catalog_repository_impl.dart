import '../../../../shared/models/plant.dart';
import '../../domain/repositories/plant_catalog_repository.dart';
import '../datasources/plant_catalog_local_datasource.dart';

class PlantCatalogRepositoryImpl implements PlantCatalogRepository {
  const PlantCatalogRepositoryImpl(this._dataSource);

  final PlantCatalogLocalDataSource _dataSource;

  @override
  List<Plant> getAll() => _dataSource.getAll();

  @override
  Plant? findById(String id) => _dataSource.findById(id);
}
