
import 'package:flutter/material.dart';

class MyTheme with ChangeNotifier {
  bool _isDark = false;

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}