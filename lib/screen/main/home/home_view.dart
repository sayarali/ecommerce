import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/screen/main/home/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> {
  HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        onPageBuilder: (context, value) => buildScaffold,
        viewModel: HomeViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          viewModel = model;
          model.init();
        });
  }

  Scaffold get buildScaffold => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Observer(builder: (context) {
            return Text(viewModel.user.email);
          }),
          ElevatedButton(onPressed: (){
            viewModel.signOut();
          }, child: Text("Çıkış Yap"))
            ],
          ),
        ),
      );
}
