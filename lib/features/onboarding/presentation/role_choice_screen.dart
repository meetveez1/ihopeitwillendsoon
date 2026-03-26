import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/app_enums.dart';
import '../../../../shared/layouts/gradient_scaffold.dart';
import '../../../../shared/widgets/selection_card.dart';
import '../../../settings/providers/settings_provider.dart';

class RoleChoiceScreen extends ConsumerWidget {
  const RoleChoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GradientScaffold(
      title: 'Выбор роли',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SelectionCard(
              title: 'Обучающийся',
              subtitle: 'Просмотр новостей и расписания',
              icon: Icons.person,
              onTap: () async {
                await ref.read(settingsProvider.notifier).setRole(UserRole.student);
                if (context.mounted) context.go('/interface');
              },
            ),
            SelectionCard(
              title: 'Администратор',
              subtitle: 'Управление новостями и расписанием',
              icon: Icons.admin_panel_settings,
              onTap: () async {
                await ref.read(settingsProvider.notifier).setRole(UserRole.admin);
                if (context.mounted) context.go('/interface');
              },
            ),
          ],
        ),
      ),
    );
  }
}
