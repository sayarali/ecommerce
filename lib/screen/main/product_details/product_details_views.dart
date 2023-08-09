import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/screen/main/product_details/viewmodel/product_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/base/state/base_state.dart';
import '../../../core/model/product_model.dart';
import '../../../core/service/firebase_service.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({Key key, this.productModel}) : super(key: key);
  final ProductModel productModel;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends BaseState<ProductDetailsView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        onPageBuilder: (context, ProductDetailsViewModel viewModel) =>
            buildScaffold(viewModel),
        viewModel: ProductDetailsViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
          model.getImagesUrl(widget.productModel.productId);
        });
  }

  Scaffold buildScaffold(ProductDetailsViewModel viewModel) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: themeData.iconTheme,
          title: Text(
            widget.productModel.productBrand.brandName,
            style: themeData.textTheme.titleMedium
                .copyWith(color: themeData.colorScheme.onBackground),
          ),
          actions: [
            widget.productModel.isLike
                ? IconButton(
                    onPressed: () async {
                      await FirebaseService()
                          .removeFavorite(widget.productModel.productId);
                      widget.productModel.isLike = false;
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.favorite_rounded,
                      color: themeData.colorScheme.error,
                    ))
                : IconButton(
                    onPressed: () async {
                      await FirebaseService()
                          .addFavorite(widget.productModel.productId);
                      widget.productModel.isLike = true;
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.favorite_outline_rounded,
                    ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: dynamicHeight(0.45),
                child: Observer(builder: (_) {
                  return viewModel.imagesUrls != null
                      ? viewModel.imagesUrls.isNotEmpty
                          ? PageView.builder(
                              itemCount: viewModel.imagesUrls.length,
                              itemBuilder: (context, index) {
                                final imageURL = viewModel.imagesUrls[index];
                                return Image.network(imageURL);
                              },
                            )
                          : Text("Ürün Fotoğrafı Yok!")
                      : CircularProgressIndicator();
                }),
              ),
              ListTile(
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    widget.productModel.productBrand.brandName,
                    style: themeData.textTheme.titleMedium
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                title: Text(
                  widget.productModel.productName,
                  style: themeData.textTheme.bodyMedium,
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Bu hafta ${widget.productModel.productWeeksViews} kez incelendi",
                          style: themeData.textTheme.bodySmall,
                        ),
                      ),
                      Divider(),
                      Text(
                        widget.productModel.productExplanation,
                      ),
                    ],
                  ))
            ],
          ),
        ),
        persistentFooterButtons: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Ücretsiz Kargo"),
              Row(
                children: [
                  Text(
                    "${widget.productModel.productPrice}₺",
                    style: themeData.textTheme.bodyLarge
                        .copyWith(color: Colors.lightGreen),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.add_shopping_cart_rounded),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Sepete eklenecek")));
                    },
                    label: Text("Sepete Ekle"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            themeData.colorScheme.secondary)),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
