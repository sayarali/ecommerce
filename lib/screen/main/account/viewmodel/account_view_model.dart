import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/components/app_progress.dart';
import 'package:ecommerce/core/init/notifier/theme_notifier.dart';
import 'package:ecommerce/core/init/theme/app_theme_dark.dart';
import 'package:ecommerce/core/model/user_model.dart';
import 'package:ecommerce/core/service/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'account_view_model.g.dart';

class AccountViewModel = AccountViewModelBase with _$AccountViewModel;

abstract class AccountViewModelBase with Store, BaseViewModel {
  FirebaseAuthService firebaseService = FirebaseAuthService();

  TextEditingController phoneController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();

  @observable
  UserModel userModel;
  @observable
  bool emailVerified = false;

  @observable
  bool allNotifications = false;

  @observable
  bool darkTheme;

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {
    fetchUserData();
    isEmailVerified();
    darkTheme = Provider.of<ThemeNotifier>(viewModelContext).currentTheme ==
        AppThemeDark.instance.theme;
  }

  @action
  Future<void> fetchUserData() async {
    userModel = await firebaseService.getCurrentUser();
    displayNameController.text = "${userModel.name}${userModel.lastName}";
    phoneController.text = userModel.phoneNumber;
  }

  void isEmailVerified() {
    firebaseService.authStateChanges().listen((event) {
      if (event != null) emailVerified = event.emailVerified;
    });
  }

  void logout() async {
    showProgress();
    await firebaseService.signOut();
  }

  void sendVerifyEmail() async {
    await firebaseService.sendVerificationEmail();
    showSnackBar(const Text("Doğrulama e-postası gönderildi."));
  }

  void updateName() async {
    if (displayNameController.text != "") {
      try {
        showProgress();
        await firebaseService.updateName(displayNameController.text);
        fetchUserData();
        closeProgress();
      } catch (e) {
        showSnackBar(Text(e));
      }
    }
  }

  void updatePhone() async {
    if (phoneController.text != "") {
      try {
        showProgress();
        await firebaseService.updatePhone(phoneController.text);
        fetchUserData();
        closeProgress();
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

  showProgress() => AppProgress.showProgress(viewModelContext);
  closeProgress() => AppProgress.closeProgress(viewModelContext);
}
