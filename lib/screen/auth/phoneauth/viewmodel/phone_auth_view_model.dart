import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/components/verification_code_input.dart';
import 'package:ecommerce/core/model/user_model.dart';
import 'package:ecommerce/core/service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/components/app_progress.dart';

part 'phone_auth_view_model.g.dart';

class PhoneAuthViewModel = PhoneAuthViewModelBase with _$PhoneAuthViewModel;

abstract class PhoneAuthViewModelBase with Store, BaseViewModel {
  FirebaseService firebaseService = FirebaseService();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController verificationCodeController =
      TextEditingController();

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  void signInWithPhoneNumber() async {
    if (phoneController.text != "") {
      firebaseService.sendCodeToPhoneNumber("+90${phoneController.text}");
      showProgress();
      firebaseService.verificationIdStream.listen((verificationId) {
        closeProgress();
        if (verificationId == 'too-many-requests') {
          buildSnackBar(
              "Çok fazla deneme yaptınız, lütfen daha sonra tekrar deneyiniz");
        } else {
          buildSnackBar("Kod gönderildi.");
          showVerificationCodeDialog(verificationId);
        }
      });
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackBar(
          String value) =>
      ScaffoldMessenger.of(viewModelContext)
          .showSnackBar(SnackBar(content: Text(value)));

  void showVerificationCodeDialog(String verificationId) {
    showDialog(
      context: viewModelContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          contentTextStyle: TextStyle(color: Colors.black87),
          title: const Text('Doğrulama Kodu'),
          content: VerificationCodeInput(
            codeLength: 6,
            onCodeSubmitted: (String code) {
              checkCodeAndSignIn(verificationId, code);
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('İptal'),
            ),
          ],
        );
      },
    );
  }

  Future<void> checkCodeAndSignIn(String verificationId, String code) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );
      if (phoneAuthCredential != null) {
        UserModel userModel = UserModel(
          userId: phoneAuthCredential.providerId,
          phoneNumber: phoneController.text,
        );
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
        await firebaseService.addUser(userModel);
      }
    } catch(e) {
      buildSnackBar(e.toString());
    }

  }

  showProgress() => AppProgress.showProgress(viewModelContext);

  closeProgress() => AppProgress.closeProgress(viewModelContext);
}
