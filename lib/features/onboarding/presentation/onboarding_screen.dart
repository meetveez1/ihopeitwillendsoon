import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/layouts/gradient_scaffold.dart';
import '../../../../shared/widgets/gradient_button.dart';
import '../../../settings/providers/settings_provider.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preset = ref.watch(settingsProvider).settings.themePreset;
    return GradientScaffold(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Добро пожаловать в School App', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            const Text('Новости школы, расписание, профиль и удобные настройки в одном месте.', style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 30),
            GradientButton(label: 'Начать', onPressed: () => context.go('/role'), preset: preset),
          ],
        ),
      ),
    );
  }
}
