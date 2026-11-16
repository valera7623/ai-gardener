import 'package:isar_community/isar.dart';

import '../../../calendar/domain/climate_zone.dart';

part 'app_settings_record.g.dart';

@collection
class AppSettingsRecord {
  Id id = 1;

  String themeMode = 'system';
  String climateZoneId = defaultClimateZoneId;
  String recognitionBackend = 'yandex';
  String recognitionApiKey = '';
  String recognitionEndpoint = '';
  String recognitionModel = 'deepseek-v4.1-flash';
  String recognitionFolderId = '';
}
