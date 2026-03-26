import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_settings.dart';
import '../models/user.dart';

class LocalStorageService {
  static const _settingsKey = 'app_settings';
  static const _userKey = 'user';

  Future<AppSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_settingsKey);
    if (raw == null) return AppSettings.initial();
    return AppSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> saveSettings(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_settingsKey, jsonEncode(settings.toJson()));
  }

  Future<User?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_userKey);
    if (raw == null) return null;
    return User.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
