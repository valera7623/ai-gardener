import 'app_settings.dart';

abstract class SettingsRepository {
  Future<AppSettings> read();

  Future<void> save(AppSettings settings);
}
