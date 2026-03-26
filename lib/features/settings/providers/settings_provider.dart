import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/app_enums.dart';
import '../../../models/app_settings.dart';
import '../../../services/local_storage_service.dart';

class SettingsState {
  final AppSettings settings;
  final bool loading;

  const SettingsState({required this.settings, this.loading = false});

  SettingsState copyWith({AppSettings? settings, bool? loading}) {
    return SettingsState(settings: settings ?? this.settings, loading: loading ?? this.loading);
  }
}

final localStorageProvider = Provider<LocalStorageService>((ref) => LocalStorageService());

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final notifier = SettingsNotifier(ref.read(localStorageProvider));
  notifier.load();
  return notifier;
});

class SettingsNotifier extends StateNotifier<SettingsState> {
  final LocalStorageService _storage;

  SettingsNotifier(this._storage) : super(SettingsState(settings: AppSettings.initial(), loading: true));

  Future<void> load() async {
    final settings = await _storage.loadSettings();
    state = state.copyWith(settings: settings, loading: false);
  }

  Future<void> update(AppSettings settings) async {
    state = state.copyWith(settings: settings);
    await _storage.saveSettings(settings);
  }

  Future<void> setRole(UserRole role) => update(state.settings.copyWith(role: role));
  Future<void> setTheme(ThemePreset preset) => update(state.settings.copyWith(themePreset: preset));
  Future<void> setInterfaceMode(InterfaceMode mode) => update(state.settings.copyWith(interfaceMode: mode));
  Future<void> completeOnboarding() => update(state.settings.copyWith(onboardingCompleted: true));
  Future<void> setLoggedIn(bool value) => update(state.settings.copyWith(loggedIn: value));
  Future<void> setDarkMode(bool value) => update(state.settings.copyWith(darkMode: value));
  Future<void> setAnimations(bool value) => update(state.settings.copyWith(animationsEnabled: value));
}
