import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user.dart';
import '../../settings/providers/settings_provider.dart';

class AuthState {
  final User? user;
  final bool loading;
  final String? error;

  const AuthState({this.user, this.loading = false, this.error});

  AuthState copyWith({User? user, bool? loading, String? error}) {
    return AuthState(user: user ?? this.user, loading: loading ?? this.loading, error: error);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final notifier = AuthNotifier(ref);
  notifier.loadUser();
  return notifier;
});

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;
  AuthNotifier(this._ref) : super(const AuthState());

  Future<void> loadUser() async {
    final storage = _ref.read(localStorageProvider);
    final user = await storage.loadUser();
    state = state.copyWith(user: user);
  }

  Future<bool> register(User user, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      state = state.copyWith(error: 'Пароли не совпадают');
      return false;
    }
    if (password.length < 6) {
      state = state.copyWith(error: 'Пароль должен содержать минимум 6 символов');
      return false;
    }
    final storage = _ref.read(localStorageProvider);
    await storage.saveUser(user);
    await _ref.read(settingsProvider.notifier).setLoggedIn(true);
    await _ref.read(settingsProvider.notifier).setRole(user.role);
    state = state.copyWith(user: user, error: null);
    return true;
  }

  Future<bool> login(String email, String password) async {
    final storage = _ref.read(localStorageProvider);
    final user = await storage.loadUser();
    if (user == null || user.email != email || password.length < 6) {
      state = state.copyWith(error: 'Неверный email или пароль');
      return false;
    }
    await _ref.read(settingsProvider.notifier).setLoggedIn(true);
    state = state.copyWith(user: user, error: null);
    return true;
  }

  Future<void> logout() async {
    await _ref.read(settingsProvider.notifier).setLoggedIn(false);
    state = state.copyWith(user: null);
  }
}
