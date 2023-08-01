import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/core/components/gradiant_box.dart';
import 'package:ecommerce/screen/auth/register/viewmodel/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/components/text_field/custom_bordered_text_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends BaseState<RegisterView> {
  RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
        onPageBuilder: (context, value) => buildScaffold,
        viewModel: RegisterViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          viewModel = model;
          model.init();
        });
  }

  Scaffold get buildScaffold => Scaffold(
        appBar: AppBar(
          title: Text(
            "Kayıt Ol",
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Center(
                child: Column(
              children: <Widget>[
                Image(
                  image: const AssetImage('assets/register.png'),
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                Observer(
                  builder: (_) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: buildEmailCustomBorderedTextField(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 12,
                                child: buildNameCustomBorderedTextField(),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 12,
                                child: buildLastNameCustomBorderedTextField(),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: buildPasswordCustomBorderedTextField(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: buildPasswordCheckCustomBorderedTextField(),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 15),
                          child: buildRegisterElevatedButton(),
                        )
                      ],
                    );
                  },
                ),
              ],
            )),
          ),
        ),
      );

  ElevatedButton buildRegisterElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        viewModel.signUp();
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
          Text("Kayıt Ol  "),
          Icon(Icons.login_outlined)
        ],
      ),
    );
  }

  CustomBorderedTextField buildPasswordCheckCustomBorderedTextField() {
    return CustomBorderedTextField(
      labelText: "Parola tekrar",
      errorText: "* Parolalar eşleşmiyor.",
      error: viewModel.passwordCheckError,
      obscureText: !viewModel.passwordCheckVisibility,
      controller: viewModel.passwordCheckController,
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        icon: Icon(viewModel.passwordCheckVisibility != true
            ? Icons.visibility
            : Icons.visibility_off),
        onPressed: () {
          viewModel.passwordCheckVisibility =
              !viewModel.passwordCheckVisibility;
        },
      ),
      onChanged: (value) {
        if (value == viewModel.passwordController.text) {
          viewModel.passwordCheckError = false;
        } else {
          viewModel.passwordCheckError = true;
        }
      },
    );
  }

  CustomBorderedTextField buildPasswordCustomBorderedTextField() {
    return CustomBorderedTextField(
      labelText: "Parola",
      errorText: "* Parolanızı en az 6 hane olacak şekilde giriniz.",
      error: viewModel.passwordError,
      obscureText: !viewModel.passwordVisibility,
      controller: viewModel.passwordController,
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        icon: Icon(viewModel.passwordVisibility != true
            ? Icons.visibility
            : Icons.visibility_off),
        onPressed: () {
          viewModel.passwordVisibility = !viewModel.passwordVisibility;
        },
      ),
      onChanged: (value) {
        if (value.length >= 6) {
          viewModel.passwordError = false;
        } else {
          viewModel.passwordError = true;
        }
      },
    );
  }

  CustomBorderedTextField buildLastNameCustomBorderedTextField() {
    return CustomBorderedTextField(
      labelText: "Soyadı",
      errorText: "* Soyadınızı giriniz",
      error: viewModel.lastNameError,
      obscureText: false,
      controller: viewModel.lastNameController,
      prefixIcon: const Icon(Icons.person_outline),
      onChanged: (value) {
        if (value != "") {
          viewModel.lastNameError = false;
        } else {
          viewModel.lastNameError = true;
        }
      },
    );
  }

  CustomBorderedTextField buildNameCustomBorderedTextField() {
    return CustomBorderedTextField(
      labelText: "Adı",
      errorText: "* Adınızı giriniz",
      error: viewModel.nameError,
      obscureText: false,
      controller: viewModel.nameController,
      prefixIcon: const Icon(Icons.person_outline),
      onChanged: (value) {
        if (value != "") {
          viewModel.nameError = false;
        } else {
          viewModel.nameError = true;
        }
      },
    );
  }

  CustomBorderedTextField buildEmailCustomBorderedTextField() {
    return CustomBorderedTextField(
      labelText: "E-posta adresi",
      errorText: "* E-posta adresinizi giriniz",
      error: viewModel.emailError,
      obscureText: false,
      controller: viewModel.emailController,
      prefixIcon: const Icon(Icons.email_outlined),
      onChanged: (value) {
        if (value != "") {
          viewModel.emailError = false;
        } else {
          viewModel.emailError = true;
        }
      },
    );
  }
}
