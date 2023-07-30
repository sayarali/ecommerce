import 'package:ecommerce/core/init/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppThemeDark extends AppTheme{
  static AppThemeDark _instance = AppThemeDark._init();
  static AppThemeDark get instance => _instance;
  AppThemeDark._init();

  ThemeData get theme => ThemeData.dark();
}