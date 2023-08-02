import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/components/app_progress.dart';
import 'package:ecommerce/core/model/user_model.dart';
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
      } catch(e){
        ScaffoldMessenger.of(viewModelContext).showSnackBar(SnackBar(content: Text(e.toString())));
        closeProgress();
      }
    } else {
      if(emailController.text == "") emailError = true;
      if(passwordController.text == "") passwordError = true;
    }
  }
  void signInWithGoogle() async {
    try{
      showProgress();
      UserCredential user = await FirebaseService().signInWithGoogle();
      List<String> name = user.user.displayName.split(" ");
      UserModel userModel = UserModel(
        userId: user.user.uid,
        name: name.removeLast(),
        lastName: name.last,
        email: user.user.email,
        phoneNumber: user.user.phoneNumber,
        address: "",
      );
      await FirebaseService().addUser(userModel);
    } catch (e){
      closeProgress();
      ScaffoldMessenger.of(viewModelContext).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  void signInWithFacebook() async {
    try{
      showProgress();
      UserCredential user = await FirebaseService().signInWithFacebook();
      List<String> name = user.user.displayName.split(" ");
      UserModel userModel = UserModel(
        userId: user.user.uid,
        name: name.removeLast(),
        lastName: name.last,
        email: user.user.email,
        phoneNumber: user.user.phoneNumber,
        address: "",
      );
      await FirebaseService().addUser(userModel);
    } catch (e){
      closeProgress();
      ScaffoldMessenger.of(viewModelContext).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  void goToPhoneAuthView(){
    navigation.navigateToPage("/phone_auth_view");
  }
  void goRegisterView() => navigation.navigateToPage("/register_view");
  void goForgotPasswordView() => navigation.navigateToPage("/forgot_password_view");
  showProgress() => AppProgress.showProgress(viewModelContext);
  closeProgress() => AppProgress.closeProgress(viewModelContext);
}
