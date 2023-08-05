import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/service/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/components/app_progress.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store, BaseViewModel {
  FirebaseAuthService firebaseService = FirebaseAuthService();
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  void signOut() async {
    showProgress();
    await firebaseService.signOut();
  }

  showProgress() => AppProgress.showProgress(viewModelContext);
  closeProgress() => AppProgress.closeProgress(viewModelContext);
}
