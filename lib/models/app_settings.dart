import 'app_enums.dart';

class AppSettings {
  final UserRole role;
  final InterfaceMode interfaceMode;
  final ThemePreset themePreset;
  final bool darkMode;
  final bool animationsEnabled;
  final bool onboardingCompleted;
  final bool loggedIn;

  const AppSettings({
    required this.role,
    required this.interfaceMode,
    required this.themePreset,
    required this.darkMode,
    required this.animationsEnabled,
    required this.onboardingCompleted,
    required this.loggedIn,
  });

  factory AppSettings.initial() => const AppSettings(
        role: UserRole.student,
        interfaceMode: InterfaceMode.standard,
        themePreset: ThemePreset.oceanMint,
        darkMode: false,
        animationsEnabled: true,
        onboardingCompleted: false,
        loggedIn: false,
      );

  AppSettings copyWith({
    UserRole? role,
    InterfaceMode? interfaceMode,
    ThemePreset? themePreset,
    bool? darkMode,
    bool? animationsEnabled,
    bool? onboardingCompleted,
    bool? loggedIn,
  }) {
    return AppSettings(
      role: role ?? this.role,
      interfaceMode: interfaceMode ?? this.interfaceMode,
      themePreset: themePreset ?? this.themePreset,
      darkMode: darkMode ?? this.darkMode,
      animationsEnabled: animationsEnabled ?? this.animationsEnabled,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      loggedIn: loggedIn ?? this.loggedIn,
    );
  }

  Map<String, dynamic> toJson() => {
        'role': role.name,
        'interfaceMode': interfaceMode.name,
        'themePreset': themePreset.name,
        'darkMode': darkMode,
        'animationsEnabled': animationsEnabled,
        'onboardingCompleted': onboardingCompleted,
        'loggedIn': loggedIn,
      };

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      role: UserRole.values.firstWhere((e) => e.name == json['role']),
      interfaceMode: InterfaceMode.values.firstWhere((e) => e.name == json['interfaceMode']),
      themePreset: ThemePreset.values.firstWhere((e) => e.name == json['themePreset']),
      darkMode: json['darkMode'] as bool,
      animationsEnabled: json['animationsEnabled'] as bool,
      onboardingCompleted: json['onboardingCompleted'] as bool,
      loggedIn: json['loggedIn'] as bool,
    );
  }
}
