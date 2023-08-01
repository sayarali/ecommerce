import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/core/components/app_progress.dart';
import 'package:ecommerce/core/components/gradiant_box.dart';
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
            GradiantBox(a: themeData.primaryColor, b: themeData.colorScheme.secondary),
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
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Observer(
                              builder: (BuildContext context) {
                                return TextField(
                                  onChanged: (value) {
                                    if(value != ""){
                                      viewModel.emailError = false;
                                    } else {
                                      viewModel.emailError = true;
                                    }
                                  },
                                  controller: viewModel.emailController,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.mail_outline),
                                      border: InputBorder.none,
                                      hintText: "E-posta ya da telefon",
                                      errorText: viewModel.emailError == true ? "E-posta adresinizi giriniz!" : null
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Observer(
                            builder: (_) {
                              return TextField(
                                onChanged: (value){
                                  if(value != ""){
                                    viewModel.passwordError = false;
                                  } else {
                                    viewModel.passwordError = true;
                                  }
                                },
                                controller: viewModel.passwordController,
                                obscureText: !viewModel.passwordVisibility,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  border: InputBorder.none,
                                  hintText: "Parola",
                                  errorText: viewModel.passwordError == true ? "Parolanızı giriniz!": null,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      viewModel.passwordVisibility != true ? Icons.visibility : Icons.visibility_off
                                    ),
                                    onPressed: () {
                                      viewModel.passwordVisibility = !viewModel.passwordVisibility;
                                    },
                                  )
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed("/forgot_password_view");
                            },
                            child: const Text("Parolanızı mı unuttunuz?"),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 25),
                    child: ElevatedButton(
                      onPressed: (){
                        viewModel.login();
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(15)),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )),
                          backgroundColor: MaterialStateProperty.all(
                              themeData.colorScheme.secondary),
                          shadowColor: MaterialStateProperty.all(
                              themeData.colorScheme.secondary)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text("Giriş Yap  "),
                          Icon(Icons.login_outlined)
                        ],
                      ),
                    ),
                  ),
                  Row(
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
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: const Text(
                        "Sosyal medya ile devam et",
                        style: TextStyle(color: Colors.white70),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Text get buildHelloText {
    return const Text(
                  "Merhaba",
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.w200),
                  textAlign: TextAlign.start,
                );
  }
}
