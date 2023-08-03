
import 'package:ecommerce/core/constants/enums/app_theme_enum.dart';
import 'package:ecommerce/core/init/theme/app_theme_light.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppThemeLight.instance.theme;
  ThemeData get currentTheme => _currentTheme;

  void changeValue(AppThemeEnum theme){
    switch(theme) {
      case AppThemeEnum.LIGHT:
        _currentTheme = ThemeData.light();
        break;
      case AppThemeEnum.DARK:
        _currentTheme = ThemeData.dark();
        break;
    }
    notifyListeners();
  }
}