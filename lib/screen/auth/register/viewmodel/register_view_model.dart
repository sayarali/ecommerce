import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/model/user_model.dart';
import 'package:ecommerce/core/service/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/components/app_progress.dart';

part 'register_view_model.g.dart';

class RegisterViewModel = RegisterViewModelBase with _$RegisterViewModel;

abstract class RegisterViewModelBase with Store, BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();

  @observable
  bool emailError = false;
  @observable
  bool nameError = false;
  @observable
  bool lastNameError = false;
  @observable
  bool passwordError = false;
  @observable
  bool passwordCheckError = false;
  @observable
  bool passwordVisibility = false;
  @observable
  bool passwordCheckVisibility = false;

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  void signUp() async {
    if (emailController.text != "" &&
        passwordController.text.length >= 6 &&
        passwordCheckController.text == passwordController.text &&
        nameController.text != "" &&
        lastNameController.text != "") {
      showProgress();
      try {
        User user = await FirebaseAuthService()
            .signUp(emailController.text, passwordCheckController.text);
        UserModel userModel = UserModel(
          userId: user.uid,
          name: nameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          phoneNumber: "",
          address: "",
          photoUrl: "",
        );
        await user.updateDisplayName(
            "${nameController.text} ${lastNameController.text}");
        await user.updatePhotoURL("");
        await FirebaseAuthService().addUser(userModel);
        String sendEmailMessage =
            await FirebaseAuthService().sendVerificationEmail();
        ScaffoldMessenger.of(viewModelContext)
            .showSnackBar(SnackBar(content: Text(sendEmailMessage)));
      } catch (e) {
        ScaffoldMessenger.of(viewModelContext)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        closeProgress();
      }
    } else {
      if (emailController.text == "") emailError = true;
      if (nameController.text == "") nameError = true;
      if (lastNameController.text == "") lastNameError = true;
      if (passwordController.text.length < 6) passwordError = true;
      if (passwordCheckController.text != passwordController.text)
        passwordCheckError = true;
    }
  }

  showProgress() => AppProgress.showProgress(viewModelContext);

  closeProgress() => AppProgress.closeProgress(viewModelContext);
}
