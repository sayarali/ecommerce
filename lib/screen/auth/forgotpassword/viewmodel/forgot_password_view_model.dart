import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/service/firebase_service.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/app_progress.dart';

part 'forgot_password_view_model.g.dart';

class ForgotPasswordViewModel = ForgotPasswordViewModelBase
    with _$ForgotPasswordViewModel;

abstract class ForgotPasswordViewModelBase with Store, BaseViewModel {
  TextEditingController emailController = TextEditingController();

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  void sendEmail() async {
    if (emailController.text != "") {
      showProgress();
      try {
        await FirebaseService().sendPasswordResetEmail(emailController.text);
        ScaffoldMessenger.of(viewModelContext).showSnackBar(
            SnackBar(content: Text("Parola sıfırlama bağlantısı gönderildi.")));
      } catch (e) {
        ScaffoldMessenger.of(viewModelContext)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
      closeProgress();
    }
  }
  showProgress() => AppProgress.showProgress(viewModelContext);
  closeProgress() => AppProgress.closeProgress(viewModelContext);
}
