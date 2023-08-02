import 'package:ecommerce/core/init/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppThemeLight extends AppTheme {
  static AppThemeLight _instance = AppThemeLight._init();

  static AppThemeLight get instance => _instance;

  AppThemeLight._init();

  ThemeData get theme => ThemeData(
      primaryColor: Colors.orange,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.black54,
        onPrimary: Colors.white,
        secondary: Colors.red,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.white60,
        onBackground: Colors.black,
        surface: Colors.black54,
        onSurface: Colors.black,
      ),
      snackBarTheme: const SnackBarThemeData(backgroundColor: Colors.black87),
      bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white, surfaceTintColor: Colors.orange),
      unselectedWidgetColor: Colors.white10
  );
}
