import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/screen/main/categories/viewmodel/categories_view_model.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends BaseState<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        onPageBuilder: (context, CategoriesViewModel viewModel) =>
            buildScaffold(viewModel),
        viewModel: CategoriesViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        });
  }

  Scaffold buildScaffold(CategoriesViewModel viewModel) => Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Text("Kategoriler"),
        ),
      );
}
