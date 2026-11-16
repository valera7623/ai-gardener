import 'dart:io';

import 'package:ai_gardener/features/catalog/data/datasources/plant_catalog_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the recognition server lists every catalog plant', () {
    final source = File('server/lib/plants.dart').readAsStringSync();
    final plants = const PlantCatalogLocalDataSource().getAll();

    expect(plants.length, 20);
    for (final plant in plants) {
      expect(source, contains("'${plant.id}': '${plant.name}'"));
    }
  });
}
