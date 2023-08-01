import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/app_progress.dart';
part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store, BaseViewModel {
  @observable
  User user;
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }
  @override
  void init() {
    getUser();
  }
  void signOut() async {
    print("object");
    showProgress();
    await FirebaseService().signOut();
  }
  void getUser() async {
    user = await FirebaseService().getCurrentUser();
  }
  showProgress() => AppProgress.showProgress(viewModelContext);
  closeProgress() => AppProgress.closeProgress(viewModelContext);

}
