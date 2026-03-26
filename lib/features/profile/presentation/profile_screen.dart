import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../auth/providers/auth_provider.dart';
import '../../settings/providers/settings_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final settings = ref.watch(settingsProvider).settings;
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: user == null
          ? const Center(child: Text('Пользователь не авторизован'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.fullName, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(user.email),
                  const SizedBox(height: 12),
                  Text('Роль: ${settings.role.name}'),
                  Text('Интерфейс: ${settings.interfaceMode.name}'),
                  Text('Тема: ${settings.themePreset.name}'),
                  const Spacer(),
                  FilledButton.icon(
                    onPressed: () async {
                      await ref.read(authProvider.notifier).logout();
                      if (context.mounted) context.go('/login');
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Выйти'),
                  ),
                ],
              ),
            ),
    );
  }
}
