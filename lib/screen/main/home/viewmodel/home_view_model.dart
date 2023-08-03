import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/components/app_progress.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store, BaseViewModel {
  FirebaseService firebaseService = FirebaseService();
  @observable
  String displayName;
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {
    getUser();
  }

  void signOut() async {
    showProgress();
    await firebaseService.signOut();
  }

  Future getUser() async {
    final user = await firebaseService.getCurrentUser();
    displayName = user.displayName;
  }

  showProgress() => AppProgress.showProgress(viewModelContext);
  closeProgress() => AppProgress.closeProgress(viewModelContext);
}
