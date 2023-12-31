import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/constants/navigation/navigation_constants.dart';
import 'package:ecommerce/core/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'splash_view_model.g.dart';

class SplashViewModel = SplashViewModelBase with _$SplashViewModel;

abstract class SplashViewModelBase with Store, BaseViewModel {
  FirebaseAuthService firebaseService = FirebaseAuthService();
  User user;
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {
    firebaseService.authStateChanges().listen((user) {
      if (user != null) {
        Future.delayed(const Duration(seconds: 2))
            .whenComplete(() => goToHome());
      } else {
        Future.delayed(const Duration(seconds: 2))
            .whenComplete(() => goToLogin());
      }
    });
  }

  void goToLogin() {
    navigation.navigateToPageRemoveUntil(
      path: NavigationConstants.LOGIN_VIEW,
    );
  }

  void goToHome() {
    navigation.navigateToPageRemoveUntil(
      path: NavigationConstants.HOME_VIEW,
    );
  }
}
