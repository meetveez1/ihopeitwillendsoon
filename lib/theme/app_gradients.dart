import 'package:flutter/material.dart';

import '../models/app_enums.dart';

class AppGradients {
  static LinearGradient fromPreset(ThemePreset preset, {bool dark = false}) {
    switch (preset) {
      case ThemePreset.oceanMint:
        return LinearGradient(
          colors: dark
              ? const [Color(0xFF0D3B4C), Color(0xFF135A54)]
              : const [Color(0xFF2AC6B7), Color(0xFF3C8CE7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ThemePreset.emeraldWave:
        return LinearGradient(
          colors: dark
              ? const [Color(0xFF0F5132), Color(0xFF0E7490)]
              : const [Color(0xFF34D399), Color(0xFF0EA5E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case ThemePreset.tealSky:
        return LinearGradient(
          colors: dark
              ? const [Color(0xFF0F766E), Color(0xFF1E3A8A)]
              : const [Color(0xFF2DD4BF), Color(0xFF60A5FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }
}
