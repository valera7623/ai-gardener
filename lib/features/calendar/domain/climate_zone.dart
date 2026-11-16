class ClimateZone {
  const ClimateZone({
    required this.id,
    required this.name,
    required this.regions,
    required this.dayShift,
  });

  final String id;
  final String name;
  final String regions;

  /// Сдвиг сроков относительно средней полосы. Отрицательный — весна раньше.
  final int dayShift;
}

const defaultClimateZoneId = 'center';

const climateZones = <ClimateZone>[
  ClimateZone(
    id: 'northwest',
    name: 'Северо-Запад',
    regions: 'Санкт-Петербург, Карелия, Псков, Новгород',
    dayShift: 18,
  ),
  ClimateZone(
    id: 'center',
    name: 'Средняя полоса',
    regions: 'Москва, Тула, Нижний Новгород и соседние области',
    dayShift: 0,
  ),
  ClimateZone(
    id: 'chernozem',
    name: 'Черноземье',
    regions: 'Воронеж, Белгород, Тамбов, Курск',
    dayShift: -12,
  ),
  ClimateZone(
    id: 'south',
    name: 'Юг',
    regions: 'Краснодар, Ростов, Крым',
    dayShift: -25,
  ),
  ClimateZone(
    id: 'ural',
    name: 'Урал',
    regions: 'Екатеринбург, Пермь, Челябинск',
    dayShift: 14,
  ),
  ClimateZone(
    id: 'siberia',
    name: 'Сибирь',
    regions: 'Новосибирск, Красноярск, Иркутск',
    dayShift: 24,
  ),
  ClimateZone(
    id: 'farEast',
    name: 'Дальний Восток',
    regions: 'Владивосток, Хабаровск',
    dayShift: 10,
  ),
];

ClimateZone climateZoneById(String id) {
  for (final zone in climateZones) {
    if (zone.id == id) {
      return zone;
    }
  }
  return climateZones.firstWhere((zone) => zone.id == defaultClimateZoneId);
}
