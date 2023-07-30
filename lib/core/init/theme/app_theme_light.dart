import 'package:ecommerce/core/init/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppThemeLight extends AppTheme{
  static AppThemeLight _instance = AppThemeLight._init();
  static AppThemeLight get instance => _instance;
  AppThemeLight._init();

  ThemeData get theme => ThemeData.light();
}