import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/screen/auth/login/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';

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
      },
      onPageBuilder: (context, value) => buildScaffold(),
    );
  }

  Scaffold buildScaffold() {
    return const Scaffold();
  }
}
