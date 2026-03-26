import 'package:flutter/material.dart';

import '../models/app_enums.dart';
import 'app_gradients.dart';

class AppTheme {
  static ThemeData light(ThemePreset preset) {
    final gradient = AppGradients.fromPreset(preset);
    final primary = gradient.colors.last;
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.light),
      scaffoldBackgroundColor: const Color(0xFFF4FAFB),
      cardTheme: CardThemeData(
        elevation: 3,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      ),
    );
  }

  static ThemeData dark(ThemePreset preset) {
    final gradient = AppGradients.fromPreset(preset, dark: true);
    final primary = gradient.colors.last;
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.dark),
      scaffoldBackgroundColor: const Color(0xFF0B1220),
      cardTheme: CardThemeData(
        elevation: 2,
        color: const Color(0xFF111B2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
