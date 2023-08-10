import 'package:ecommerce/core/model/product_model.dart';

class BasketModel {
  ProductModel product;
  int count;

  BasketModel({
    this.product,
    this.count,
  });
}
