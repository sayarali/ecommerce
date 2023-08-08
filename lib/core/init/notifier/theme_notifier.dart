import 'package:ecommerce/core/constants/enums/app_theme_enum.dart';
import 'package:ecommerce/core/init/theme/app_theme_dark.dart';
import 'package:ecommerce/core/init/theme/app_theme_light.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppThemeLight.instance.theme;
  ThemeData get currentTheme => _currentTheme;

  void changeValue(AppThemeEnum theme) {
    switch (theme) {
      case AppThemeEnum.LIGHT:
        _currentTheme = AppThemeLight.instance.theme;
        break;
      case AppThemeEnum.DARK:
        _currentTheme = AppThemeDark.instance.theme;
        break;
    }
    notifyListeners();
  }
}
