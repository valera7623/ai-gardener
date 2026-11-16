import '../../../../shared/models/plant.dart';

abstract class PlantCatalogRepository {
  List<Plant> getAll();

  Plant? findById(String id);
}
