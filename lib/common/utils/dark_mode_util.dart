import 'package:flutter/material.dart';

class DarkModeUtil {
  static bool isDarkMode(BuildContext context, ThemeMode darkMode) {
    bool isDarkMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    return darkMode == ThemeMode.dark ||
        (darkMode == ThemeMode.system && isDarkMode);
  }
}