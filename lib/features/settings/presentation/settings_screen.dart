import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/app_enums.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).settings;
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          SwitchListTile(
            title: const Text('Тёмная тема'),
            value: settings.darkMode,
            onChanged: notifier.setDarkMode,
          ),
          SwitchListTile(
            title: const Text('Анимации'),
            value: settings.animationsEnabled,
            onChanged: notifier.setAnimations,
          ),
          ListTile(
            title: const Text('Режим интерфейса'),
            subtitle: Text(settings.interfaceMode.name),
            trailing: DropdownButton<InterfaceMode>(
              value: settings.interfaceMode,
              items: InterfaceMode.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
              onChanged: (v) => v == null ? null : notifier.setInterfaceMode(v),
            ),
          ),
          ListTile(
            title: const Text('Роль (demo)'),
            subtitle: Text(settings.role.name),
            trailing: DropdownButton<UserRole>(
              value: settings.role,
              items: UserRole.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
              onChanged: (v) => v == null ? null : notifier.setRole(v),
            ),
          ),
          ListTile(
            title: const Text('Тема'),
            subtitle: Text(settings.themePreset.name),
            trailing: DropdownButton<ThemePreset>(
              value: settings.themePreset,
              items: ThemePreset.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
              onChanged: (v) => v == null ? null : notifier.setTheme(v),
            ),
          ),
          const AboutListTile(
            applicationName: 'School App',
            applicationVersion: '1.0.0',
            applicationLegalese: 'Demo MVP for school management UI',
          ),
        ],
      ),
    );
  }
}
