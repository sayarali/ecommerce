import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/constants/navigation/navigation_constants.dart';
import 'package:ecommerce/core/model/product_model.dart';
import 'package:ecommerce/core/projectstyles/project_styles.dart';
import 'package:ecommerce/core/service/firebase_service.dart';
import 'package:flutter/material.dart';

import '../../init/navigation/navigation_service.dart';

class HorizontalProductCard extends StatefulWidget {
  const HorizontalProductCard(
      {Key key, this.productModel, this.themeData, this.onPressed})
      : super(key: key);
  final ProductModel productModel;
  final ThemeData themeData;
  final VoidCallback onPressed;

  @override
  State<HorizontalProductCard> createState() => _HorizontalProductCardState();
}

class _HorizontalProductCardState extends BaseState<HorizontalProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationService.instance.navigateToPage(
            path: NavigationConstants.PRODUCT_DETAILS_VIEW,
            data: widget.productModel);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: ProjectStyles.boxDecoration,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.network(
                widget.productModel.productImageThumbnailUrl,
                errorBuilder: (context, object, stackTrace) {
                  return CircleAvatar(
                    child: Icon(Icons.not_interested_rounded),
                  );
                },
                scale: 0.1,
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productModel.productBrand.brandName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.productModel.productName,
                            softWrap: true,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Text(
                          "${widget.productModel.productPrice} ₺",
                          style: themeData.textTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.lightGreen),
                        )),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          OutlinedButton(
                            onPressed: () async {
                              await FirebaseService()
                                  .addBasket(widget.productModel.productId);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Ürün sepete eklendi.")));
                            },
                            child: Text(
                              "Sepete Ekle",
                              style: themeData.textTheme.labelMedium,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.productModel.isLike
                        ? IconButton(
                            icon: Icon(
                              Icons.favorite_rounded,
                              color: themeData.colorScheme.error,
                            ),
                            onPressed: () async {
                              await FirebaseService().removeFavorite(
                                  widget.productModel.productId);
                              widget.productModel.isLike = false;
                              setState(() {});
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.favorite_border_rounded),
                            onPressed: () async {
                              await FirebaseService()
                                  .addFavorite(widget.productModel.productId);
                              widget.productModel.isLike = true;
                              setState(() {});
                            },
                          )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
