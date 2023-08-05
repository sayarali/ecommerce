import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/core/components/gradiant_box.dart';
import 'package:ecommerce/core/components/text_field/custom_text_field.dart';
import 'package:ecommerce/screen/auth/login/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/base/state/base_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView> {
  LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: LoginViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
        model.init();
      },
      onPageBuilder: (context, value) => buildScaffold,
    );
  }

  Scaffold get buildScaffold {
    return Scaffold(
      body: GestureDetector(
        onTap: (() => FocusScope.of(context).unfocus()),
        child: Stack(
          children: <Widget>[
            GradiantBox(
                a: themeData.primaryColor, b: themeData.colorScheme.secondary),
            SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(vertical: 140, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildHelloText,
                  Container(
                    margin: const EdgeInsets.only(top: 65),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: themeData.colorScheme.background,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: themeData.colorScheme.secondary,
                            blurRadius: 50,
                          )
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color:
                                          themeData.colorScheme.onBackground))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Observer(
                              builder: (BuildContext context) {
                                return buildEmailCustomTextField();
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Observer(
                            builder: (_) {
                              return buildPasswordCustomTextField();
                            },
                          ),
                        ),
                        buildForgotPasswordContainer()
                      ],
                    ),
                  ),
                  buildLoginButtonContainer(),
                  buildRegisterRow(),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: const Text(
                        "ya da",
                        style: TextStyle(color: Colors.white70),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: themeData.primaryColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                            onPressed: () {
                              viewModel.goToPhoneAuthView();
                            },
                            icon: Icon(Icons.phone)),
                      ),
                      Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: themeData.primaryColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          onPressed: () {
                            viewModel.signInWithGoogle();
                          },
                          icon: Image.asset(
                            "assets/google.png",
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: themeData.primaryColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                            onPressed: () {
                              viewModel.signInWithFacebook();
                            },
                            icon: Image.asset(
                              "assets/facebook.png",
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildRegisterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Henüz bir hesabınız yok mu?",
          style: TextStyle(color: Colors.white70),
        ),
        TextButton(
          onPressed: () {
            viewModel.goRegisterView();
          },
          child: const Text(
            "Kayıt Olun!",
            style: TextStyle(color: Colors.white70),
          ),
        )
      ],
    );
  }

  Container buildLoginButtonContainer() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 25),
      child: ElevatedButton(
        onPressed: () {
          viewModel.login();
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            )),
            backgroundColor:
                MaterialStateProperty.all(themeData.colorScheme.secondary),
            shadowColor:
                MaterialStateProperty.all(themeData.colorScheme.secondary)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text("Giriş Yap  "),
            Icon(Icons.login_outlined)
          ],
        ),
      ),
    );
  }

  Container buildForgotPasswordContainer() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          viewModel.goForgotPasswordView();
        },
        child: const Text("Parolanızı mı unuttunuz?"),
      ),
    );
  }

  CustomTextField buildPasswordCustomTextField() {
    return CustomTextField(
        onChanged: (value) {
          if (value != "") {
            viewModel.passwordError = false;
          } else {
            viewModel.passwordError = true;
          }
        },
        controller: viewModel.passwordController,
        obscureText: !viewModel.passwordVisibility,
        prefixIcon: const Icon(Icons.lock_outline),
        errorText: "Parolanızı giriniz!",
        error: viewModel.passwordError,
        hintText: "Parola",
        suffixIcon: IconButton(
          icon: Icon(viewModel.passwordVisibility != true
              ? Icons.visibility_off
              : Icons.visibility),
          onPressed: () {
            viewModel.passwordVisibility = !viewModel.passwordVisibility;
          },
        ));
  }

  CustomTextField buildEmailCustomTextField() {
    return CustomTextField(
      controller: viewModel.emailController,
      hintText: "E-posta",
      prefixIcon: Icon(Icons.email_outlined),
      errorText: "E-posta adresinizi giriniz.",
      error: viewModel.emailError,
      obscureText: false,
      onChanged: (value) {
        if (value != "") {
          viewModel.emailError = false;
        } else {
          viewModel.emailError = true;
        }
      },
    );
  }

  Text get buildHelloText {
    return const Text(
      "Merhaba",
      style: TextStyle(
          fontSize: 50, color: Colors.white, fontWeight: FontWeight.w200),
      textAlign: TextAlign.start,
    );
  }
}
