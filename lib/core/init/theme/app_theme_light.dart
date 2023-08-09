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
      unselectedWidgetColor: Colors.white12,
      chipTheme: const ChipThemeData(
          backgroundColor: Colors.white38,
          selectedColor: Colors.orange,
          brightness: Brightness.light),
      iconTheme: const IconThemeData(color: Colors.black87),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              iconColor: MaterialStateProperty.all(Colors.black87))),
      buttonTheme: const ButtonThemeData(buttonColor: Colors.orange),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: 18)));
}
