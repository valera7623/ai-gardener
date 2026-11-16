import 'package:flutter/material.dart';

import '../../calendar/domain/climate_zone.dart';
import '../../recognition/domain/recognition_connection.dart';

class AppSettings {
  const AppSettings({
    required this.themeMode,
    required this.climateZoneId,
    this.connection = RecognitionConnection.defaults,
  });

  final ThemeMode themeMode;
  final String climateZoneId;
  final RecognitionConnection connection;

  static const defaults = AppSettings(
    themeMode: ThemeMode.system,
    climateZoneId: defaultClimateZoneId,
  );

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? climateZoneId,
    RecognitionConnection? connection,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      climateZoneId: climateZoneId ?? this.climateZoneId,
      connection: connection ?? this.connection,
    );
  }
}
