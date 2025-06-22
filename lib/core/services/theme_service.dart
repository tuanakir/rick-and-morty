import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ThemeService {
  final _box = Hive.box('settings');

  ThemeMode get theme => _loadThemeFromBox();

  ThemeMode _loadThemeFromBox() {
    if (_box.containsKey('isDarkMode')) {
      return _box.get('isDarkMode') ? ThemeMode.dark : ThemeMode.light;
    } else {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final isDark = brightness == Brightness.dark;
      saveTheme(isDark);
      return isDark ? ThemeMode.dark : ThemeMode.light;
    }
  }

  void saveTheme(bool isDarkMode) => _box.put('isDarkMode', isDarkMode);

  void switchTheme() {
    final current = _loadThemeFromBox();
    final isDark = current == ThemeMode.dark;
    final newTheme = isDark ? ThemeMode.light : ThemeMode.dark;
    Get.changeThemeMode(newTheme);
    saveTheme(!isDark);
  }
}
