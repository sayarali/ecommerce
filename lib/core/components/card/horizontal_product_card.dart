import 'package:ecommerce/core/model/product_model.dart';
import 'package:ecommerce/core/projectstyles/project_styles.dart';
import 'package:flutter/material.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({
    Key key,
    this.productModel,
    this.themeData,
    this.onPressed,
  }) : super(key: key);
  final ProductModel productModel;
  final ThemeData themeData;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: ProjectStyles.boxDecoration,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.network(
                productModel.productImageThumbnailUrl,
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
                            productModel.productBrand.brandName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            productModel.productName,
                            softWrap: true,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Text(
                          "${productModel.productPrice} ₺",
                          style: themeData.textTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.lightGreen),
                        )),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {},
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
                    IconButton(
                      icon: const Icon(Icons.favorite_border_rounded),
                      onPressed: () {
                        print(productModel.productId);
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
