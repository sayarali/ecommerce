import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/core/components/card/horizontal_product_card.dart';
import 'package:ecommerce/screen/main/favorites/viewmodel/favorite_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends BaseState<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        onPageBuilder: (context, FavoriteViewModel viewModel) =>
            buildScaffold(viewModel),
        viewModel: FavoriteViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        });
  }

  Scaffold buildScaffold(FavoriteViewModel viewModel) => Scaffold(
        appBar: AppBar(
          title: Text("Favorilerim"),
          leading: Icon(Icons.favorite_rounded),
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
                              child: Text("Favorilerimde hiç ürün yok."),
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
