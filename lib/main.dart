import 'package:ecommerce/core/init/navigation/navigation_route.dart';
import 'package:ecommerce/core/init/navigation/navigation_service.dart';
import 'package:ecommerce/core/init/notifier/application_provider.dart';
import 'package:ecommerce/core/init/notifier/theme_notifier.dart';
import 'package:ecommerce/screen/auth/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [...ApplicationProvider.instance.singleItems],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<ThemeNotifier>().currentTheme,
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      home: const SplashView(),
    );
  }
}