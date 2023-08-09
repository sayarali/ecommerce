import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/screen/main/products/viewmodel/products_view_model.dart';
import 'package:flutter/material.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({Key key, this.products}) : super(key: key);
  final Map<String, dynamic> products;

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends BaseState<ProductsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        onPageBuilder: (context, ProductsViewModel viewModel) =>
            buildScaffold(viewModel),
        viewModel: ProductsViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
          model.fetchProducts(widget.products["brand"],
              widget.products["category"], widget.products["option"]);
        });
  }

  Scaffold buildScaffold(ProductsViewModel viewModel) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(widget.products["title"]),
        ),
      );
}
