import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/app_enums.dart';
import '../../../../shared/layouts/gradient_scaffold.dart';
import '../../../../shared/widgets/selection_card.dart';
import '../../../settings/providers/settings_provider.dart';

class InterfaceChoiceScreen extends ConsumerWidget {
  const InterfaceChoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GradientScaffold(
      title: 'Тип интерфейса',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SelectionCard(
              title: 'Обычный',
              subtitle: 'Статичный аккуратный интерфейс',
              icon: Icons.dashboard_customize,
              onTap: () async {
                await ref.read(settingsProvider.notifier).setInterfaceMode(InterfaceMode.standard);
                if (context.mounted) context.go('/theme');
              },
            ),
            SelectionCard(
              title: 'Анимированный',
              subtitle: 'Фон с мягкими движущимися квадратами',
              icon: Icons.auto_awesome,
              onTap: () async {
                await ref.read(settingsProvider.notifier).setInterfaceMode(InterfaceMode.animated);
                if (context.mounted) context.go('/theme');
              },
            ),
          ],
        ),
      ),
    );
  }
}
