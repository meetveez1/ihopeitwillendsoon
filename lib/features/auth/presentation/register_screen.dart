import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/app_enums.dart';
import '../../../models/user.dart';
import '../../../shared/layouts/gradient_scaffold.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/gradient_button.dart';
import '../../settings/providers/settings_provider.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _surname = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _surname.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final role = ref.watch(settingsProvider).settings.role;
    final preset = ref.watch(settingsProvider).settings.themePreset;
    final authState = ref.watch(authProvider);

    return GradientScaffold(
      title: 'Регистрация',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(label: 'Имя', controller: _name, validator: (v) => (v == null || v.isEmpty) ? 'Введите имя' : null),
                  const SizedBox(height: 10),
                  AppTextField(label: 'Фамилия', controller: _surname, validator: (v) => (v == null || v.isEmpty) ? 'Введите фамилию' : null),
                  const SizedBox(height: 10),
                  AppTextField(label: 'Email', controller: _email, validator: (v) => (v != null && v.contains('@')) ? null : 'Некорректный email'),
                  const SizedBox(height: 10),
                  AppTextField(label: 'Пароль', controller: _password, obscureText: true),
                  const SizedBox(height: 10),
                  AppTextField(label: 'Подтверждение пароля', controller: _confirm, obscureText: true),
                  const SizedBox(height: 10),
                  Align(alignment: Alignment.centerLeft, child: Text('Роль: ${role == UserRole.student ? 'Обучающийся' : 'Администратор'}')),
                  if (authState.error != null) ...[
                    const SizedBox(height: 8),
                    Text(authState.error!, style: const TextStyle(color: Colors.red)),
                  ],
                  const SizedBox(height: 12),
                  GradientButton(
                    label: 'Зарегистрироваться',
                    preset: preset,
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      final ok = await ref.read(authProvider.notifier).register(
                            User(firstName: _name.text, lastName: _surname.text, email: _email.text, role: role),
                            _password.text,
                            _confirm.text,
                          );
                      if (ok && context.mounted) context.go('/home');
                    },
                  ),
                  TextButton(onPressed: () => context.go('/login'), child: const Text('Уже есть аккаунт? Войти')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
