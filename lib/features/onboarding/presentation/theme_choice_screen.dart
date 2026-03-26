import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/app_enums.dart';
import '../../../../theme/app_gradients.dart';
import '../../../../shared/layouts/gradient_scaffold.dart';
import '../../../settings/providers/settings_provider.dart';

class ThemeChoiceScreen extends ConsumerWidget {
  const ThemeChoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(settingsProvider.notifier);
    return GradientScaffold(
      title: 'Выбор темы',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: ThemePreset.values.map((preset) {
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(14),
              title: Text(preset.name),
              subtitle: const Text('Зелёно-синий градиент'),
              leading: CircleAvatar(backgroundImage: null, backgroundColor: Colors.transparent, child: Container(decoration: BoxDecoration(gradient: AppGradients.fromPreset(preset), shape: BoxShape.circle))),
              onTap: () async {
                await notifier.setTheme(preset);
                await notifier.completeOnboarding();
                if (context.mounted) context.go('/register');
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
