import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/settings/providers/settings_provider.dart';
import '../../models/app_enums.dart';
import '../../theme/app_gradients.dart';
import '../background/animated_squares_background.dart';

class GradientScaffold extends ConsumerWidget {
  final Widget child;
  final String? title;
  final bool useSafeArea;

  const GradientScaffold({super.key, required this.child, this.title, this.useSafeArea = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).settings;
    Widget content = Container(
      decoration: BoxDecoration(gradient: AppGradients.fromPreset(settings.themePreset, dark: settings.darkMode)),
      child: useSafeArea ? SafeArea(child: child) : child,
    );

    if (settings.interfaceMode == InterfaceMode.animated && settings.animationsEnabled) {
      content = AnimatedSquaresBackground(child: content);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: title == null ? null : AppBar(backgroundColor: Colors.transparent, title: Text(title!)),
      body: content,
    );
  }
}
