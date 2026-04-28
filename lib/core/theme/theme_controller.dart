import 'package:flutter/material.dart';
import 'package:tasky_app/core/services/preference_manger.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );
  void init() {
    final theme = PreferenceManger().getBool('theme') ?? true;
    themeNotifier.value = theme ? ThemeMode.dark : ThemeMode.light;
  }

  static void toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PreferenceManger().setBool('theme', false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PreferenceManger().setBool('theme', true);
    }
  }

  static bool get isDark => themeNotifier.value == ThemeMode.dark;
}
