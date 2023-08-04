import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/components/app_progress.dart';
import 'package:ecommerce/core/service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'account_view_model.g.dart';

class AccountViewModel = AccountViewModelBase with _$AccountViewModel;

abstract class AccountViewModelBase with Store, BaseViewModel {
  FirebaseService firebaseService = FirebaseService();

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  @observable
  User user;

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {
    firebaseService.authStateChanges().listen((event) {
      FirebaseAuth.instance.currentUser.reload();
      user = event;
    });
    getUser();
  }

  @action
  Future getUser() async {
    user = await firebaseService.getCurrentUser();
    phoneController.text = user.phoneNumber;
    emailController.text = user.email;
    displayNameController.text = user.displayName;
    print(user.uid);
  }

  void logout() async {
    AppProgress.showProgress(viewModelContext);
    await firebaseService.signOut();
  }

  void sendVerifyEmail() async {
    await firebaseService.sendVerificationEmail();
    showSnackBar(Text("Doğrulama e-postası gönderildi."));
  }

  void updateEmail() async {
    if (emailController.text != "") {
      try {
        await firebaseService.updateEmail(emailController.text);
      } catch (e) {
        showSnackBar(Text(e));
      }
    }
  }

  void updateName() async {
    if (displayNameController.text != "") {
      try {
        await firebaseService.updateName(displayNameController.text);
      } catch (e) {
        showSnackBar(Text(e));
      }
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      Widget content) {
    return ScaffoldMessenger.of(viewModelContext)
        .showSnackBar(SnackBar(content: content));
  }
}
