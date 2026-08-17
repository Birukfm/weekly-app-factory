import 'package:flutter/material.dart';

import '../config/app_config.dart';

class FactoryTheme {
  const FactoryTheme._();

  static ThemeData get dark {
    final ColorScheme colors = ColorScheme.fromSeed(
      seedColor: AppConfig.seedColor,
      brightness: Brightness.dark,
    ).copyWith(tertiary: AppConfig.accentGold);
    return ThemeData(
      colorScheme: colors,
      useMaterial3: true,
      scaffoldBackgroundColor: colors.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        elevation: 0,
        centerTitle: true,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surfaceContainer,
        indicatorColor: colors.primaryContainer,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
        ),
      ),
    );
  }
}
