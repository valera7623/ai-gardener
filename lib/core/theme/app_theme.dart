import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.forest,
          brightness: Brightness.light,
          surface: AppColors.paper,
        ).copyWith(
          primary: AppColors.forest,
          onPrimary: Colors.white,
          primaryContainer: const Color(0xFFD7E8DC),
          onPrimaryContainer: const Color(0xFF143526),
          secondary: const Color(0xFF8A6244),
          onSecondary: Colors.white,
          secondaryContainer: const Color(0xFFF3E4D4),
          onSecondaryContainer: const Color(0xFF3A2718),
          surface: AppColors.paper,
          onSurface: const Color(0xFF1C241E),
          onSurfaceVariant: const Color(0xFF5C675F),
          outlineVariant: const Color(0xFFE1DCD2),
        );
    return _base(scheme, scaffold: AppColors.cream);
  }

  static ThemeData get dark {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.forest,
          brightness: Brightness.dark,
          surface: AppColors.nightSurface,
        ).copyWith(
          primary: const Color(0xFF9DCEB0),
          onPrimary: const Color(0xFF123224),
          primaryContainer: const Color(0xFF234838),
          onPrimaryContainer: const Color(0xFFD7E8DC),
          secondary: const Color(0xFFE2C2A4),
          onSecondary: const Color(0xFF3A2718),
          secondaryContainer: const Color(0xFF3A2E24),
          onSecondaryContainer: const Color(0xFFF3E4D4),
          surface: AppColors.nightSurface,
          onSurface: const Color(0xFFE7EEE8),
          onSurfaceVariant: const Color(0xFFB7C2BA),
          outlineVariant: const Color(0xFF34403A),
        );
    return _base(scheme, scaffold: AppColors.night);
  }

  static ThemeData _base(ColorScheme scheme, {required Color scaffold}) {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
    );
    final textTheme = base.textTheme.copyWith(
      headlineSmall: base.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      titleLarge: base.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      titleMedium: base.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: base.textTheme.bodyLarge?.copyWith(height: 1.4),
      bodyMedium: base.textTheme.bodyMedium?.copyWith(height: 1.4),
    );

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: scaffold,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: scheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: buttonShape,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: buttonShape,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant),
    );
  }
}
