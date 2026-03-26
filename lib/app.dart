import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'theme/app_theme.dart';
import 'features/settings/providers/settings_provider.dart';

class SchoolApp extends ConsumerWidget {
  const SchoolApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'School App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(settingsState.settings.themePreset),
      darkTheme: AppTheme.dark(settingsState.settings.themePreset),
      themeMode: settingsState.settings.darkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: router,
    );
  }
}
