import 'package:ai_gardener/features/catalog/data/datasources/plant_catalog_local_datasource.dart';
import 'package:ai_gardener/shared/models/plant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const catalog = PlantCatalogLocalDataSource();

  test('catalog contains popular indoor and garden plants', () {
    final plants = catalog.getAll();

    expect(plants.length, greaterThanOrEqualTo(15));
    expect(plants.length, lessThanOrEqualTo(20));
    expect(
      plants.map((plant) => plant.id),
      containsAll(['monstera', 'tomato', 'rose', 'phalaenopsis']),
    );
    expect(
      plants.where((plant) => plant.category == PlantCategory.indoor),
      isNotEmpty,
    );
    expect(
      plants.where((plant) => plant.category == PlantCategory.garden),
      isNotEmpty,
    );
    for (final plant in plants) {
      expect(plant.care, isNotEmpty);
      expect(plant.summary, isNotEmpty);
    }
  });
}
