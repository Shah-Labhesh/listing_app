import 'package:flutter/material.dart';
import 'package:listing_app/utils/local_storage_utils.dart';

class ThemeChanger extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeChanger(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      LocalStorageUtils.saveThemeMode(true);
    } else {
      _themeMode = ThemeMode.light;
      LocalStorageUtils.saveThemeMode(false);
    }
    notifyListeners();
  }

  bool isDark() {
    return _themeMode == ThemeMode.dark;
  }
}