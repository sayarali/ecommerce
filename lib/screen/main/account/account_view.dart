import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/screen/main/account/viewmodel/account_view_model.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends BaseState<AccountView> {
  AccountViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView(
        onPageBuilder: (context, value) => buildScaffold,
        viewModel: AccountViewModel(),
        onModelReady: (model) {
          viewModel = model;
          model.setContext(context);
          model.init();
        });
  }

  Scaffold get buildScaffold => Scaffold(
        body: Container(color: Colors.green),
      );
}
