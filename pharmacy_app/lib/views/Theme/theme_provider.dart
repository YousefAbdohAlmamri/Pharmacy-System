import 'package:flutter/material.dart';
import 'theme.dart';

class ThemeProvider extends ChangeNotifier {
  static ThemeData _currentTheme = AppThemes.lightTheme;
  static bool _isDarkMode = false;

  static ThemeData get currentTheme => _currentTheme;
  static bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _currentTheme = _isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme;
    notifyListeners();
  }
}
