import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/screen/auth/splash/viewmodel/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends BaseState<SplashView> {
  SplashViewModel viewModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
        onPageBuilder: (context, value) => scaffoldBody,
        onModelReady: (model) {
          model.setContext(context);
          viewModel = model;
          model.init();
        },
        viewModel: SplashViewModel());
  }

  Widget get scaffoldBody => Scaffold(
        body: Center(
          child: Image.asset(
            'assets/loading.gif',
            width: 180,
            color: themeData.primaryColor,
          ),
        ),
      );
}
