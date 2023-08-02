import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/core/components/text_field/custom_bordered_text_field.dart';
import 'package:ecommerce/screen/auth/forgotpassword/viewmodel/forgot_password_view_model.dart';
import 'package:flutter/material.dart';

import '../../../core/components/gradiant_box.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key key}) : super(key: key);


  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends BaseState<ForgotPasswordView> {
  ForgotPasswordViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView(
        onPageBuilder: (context, value) => buildScaffold,
        viewModel: ForgotPasswordViewModel(),
        onModelReady: (model) {
          viewModel = model;
          model.init();
          model.setContext(context);
        });
  }
  Scaffold get buildScaffold => Scaffold(
    appBar: AppBar(
      title: Text(
        "Parolanızı Sıfırlayın",
        style: themeData.textTheme.titleLarge.copyWith(
            color: themeData.cardColor, fontWeight: FontWeight.w300),
      ),
      flexibleSpace: GradiantBox(
        a: themeData.primaryColor,
        b: themeData.colorScheme.secondary,
      ),
    ),
    body: GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: const AssetImage('assets/forgotpassword.png'),
                width: dynamicWidth(0.6),
              ),
              const Text("Parola sıfırlama bağlantısı e-posta adresinize gönderilecektir."),
              const SizedBox(height: 10,),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text("Lütfen e-posta adresini giriniz:")),
              const SizedBox(height: 10,),
              CustomBorderedTextField(
                controller: viewModel.emailController,
                prefixIcon: Icon(Icons.email_outlined),
                obscureText: false,
                labelText: "E-posta adresi",
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.sendEmail();
                      },
                      child: Text("Gönder",),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )),
                          backgroundColor:
                          MaterialStateProperty.all(themeData.colorScheme.secondary),
                          shadowColor:
                          MaterialStateProperty.all(themeData.colorScheme.secondary)),
                  ),),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}


