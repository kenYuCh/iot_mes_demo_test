import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeModeKey = 'app_theme_mode';

final initialThemeModeProvider = Provider<ThemeMode>(
  (ref) => ThemeMode.system,
);

final themeModeProvider = NotifierProvider<ThemeModeController, ThemeMode>(
  ThemeModeController.new,
);

class ThemeModeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ref.watch(initialThemeModeProvider);

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_themeModeKey, mode.name);
  }
}

Future<ThemeMode> loadSavedThemeMode() async {
  final preferences = await SharedPreferences.getInstance();
  final saved = preferences.getString(_themeModeKey);
  return ThemeMode.values.where((mode) => mode.name == saved).firstOrNull ??
      ThemeMode.system;
}
