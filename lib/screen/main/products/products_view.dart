import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/core/components/card/horizontal_product_card.dart';
import 'package:ecommerce/screen/main/products/viewmodel/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.sort_rounded))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Observer(builder: (_) {
                  return viewModel.productsList != null
                      ? viewModel.productsList.isEmpty
                          ? Center(
                              child: Text("Bu kategoride ürün yok."),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: viewModel.productsList.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: dynamicHeight(0.18),
                                  child: HorizontalProductCard(
                                    productModel: viewModel.productsList[index],
                                    themeData: themeData,
                                    onPressed: () {},
                                  ),
                                );
                              })
                      : const Center(child: LinearProgressIndicator());
                }),
              ),
            ],
          ),
        ),
      );
}
