import 'package:flutter/material.dart';

import '../../models/app_enums.dart';
import '../../theme/app_gradients.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ThemePreset preset;

  const GradientButton({super.key, required this.label, required this.onPressed, required this.preset});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.fromPreset(preset),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
        ),
        child: Text(label),
      ),
    );
  }
}
