import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    // Save the theme preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode.toString());
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('themeMode') ?? ThemeMode.system.toString();
    _themeMode = ThemeMode.values.firstWhere((e) => e.toString() == themeString, orElse: () => ThemeMode.system);
    notifyListeners();
  }
}
