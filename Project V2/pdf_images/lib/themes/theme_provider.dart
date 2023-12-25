import 'package:flutter/material.dart';
import 'package:pdf_images/themes/dark_theme.dart';
import 'package:pdf_images/themes/light_theme.dart';


class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(bool isDarkMode) : _themeData = isDarkMode ? darkTheme() : lightTheme();

  getTheme() => _themeData;

  setTheme(bool isDarkMode) {
    _themeData = isDarkMode ? darkTheme() : lightTheme();
    notifyListeners();
  }
}

