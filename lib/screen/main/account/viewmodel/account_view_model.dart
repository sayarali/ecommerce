import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'account_view_model.g.dart';

class AccountViewModel = AccountViewModelBase with _$AccountViewModel;

abstract class AccountViewModelBase with Store, BaseViewModel {
  User user;

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  void getUser() async {
    user = await FirebaseService().getCurrentUser();
  }
}
