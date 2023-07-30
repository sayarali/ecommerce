import 'package:ecommerce/core/constants/navigation/navigation_constants.dart';
import 'package:ecommerce/screen/auth/login/login_view.dart';
import 'package:ecommerce/screen/auth/splash/splash_view.dart';
import 'package:flutter/material.dart';

class NavigationRoute {
  NavigationRoute._init();

  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.SPLASH_SCREEN:
        return normalNavigate(const SplashView());
      case NavigationConstants.LOGIN_VIEW:
        return normalNavigate(const LoginView());
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(child: Text("Sayfa bulunamadı!")),
                ));
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}