import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/layouts/gradient_scaffold.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../settings/providers/settings_provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _rememberMe = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preset = ref.watch(settingsProvider).settings.themePreset;
    final authState = ref.watch(authProvider);

    return GradientScaffold(
      title: 'Вход',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(label: 'Email', controller: _email, validator: (v) => (v != null && v.contains('@')) ? null : 'Введите email'),
                  const SizedBox(height: 10),
                  AppTextField(label: 'Пароль', controller: _password, obscureText: true),
                  CheckboxListTile(
                    value: _rememberMe,
                    onChanged: (v) => setState(() => _rememberMe = v ?? true),
                    title: const Text('Запомнить меня'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  if (authState.error != null) ...[
                    Text(authState.error!, style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 8),
                  ],
                  GradientButton(
                    label: 'Войти',
                    preset: preset,
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      final ok = await ref.read(authProvider.notifier).login(_email.text, _password.text);
                      if (ok && context.mounted) context.go('/home');
                    },
                  ),
                  TextButton(onPressed: () => context.go('/register'), child: const Text('Нет аккаунта? Регистрация')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
