import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/components/app_progress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/service/firebase_service.dart';

part 'login_view_model.g.dart';

class LoginViewModel = LoginViewModelBase with _$LoginViewModel;

abstract class LoginViewModelBase with Store, BaseViewModel {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @observable
  bool emailError = false;
  @observable
  bool passwordError = false;
  @observable
  bool passwordVisibility = false;

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() async {

  }

  void login() async {
    if (emailController.text != "" && passwordController.text != "")
    {
      showProgress();
      try {
        User user = await FirebaseService().signIn(
          emailController.text,
          passwordController.text,
        );
        print(await user.getIdToken());
      } catch(e){
        ScaffoldMessenger.of(viewModelContext).showSnackBar(SnackBar(content: Text(e.toString())));
      }

      closeProgress();
    } else {
      if(emailController.text == "") emailError = true;
      if(passwordController.text == "") passwordError = true;
    }
  }

  showProgress() => AppProgress.showProgress(viewModelContext);
  closeProgress() => AppProgress.closeProgress(viewModelContext);
}
