import 'package:ecommerce/core/init/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppThemeDark extends AppTheme {
  static AppThemeDark _instance = AppThemeDark._init();
  static AppThemeDark get instance => _instance;
  AppThemeDark._init();
  ThemeData get theme => ThemeData(
      primaryColor: Colors.black,
      colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.white,
          onPrimary: Colors.white,
          secondary: Colors.black26,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.black,
          onBackground: Colors.white,
          surface: Colors.black26,
          onSurface: Colors.white));
}
