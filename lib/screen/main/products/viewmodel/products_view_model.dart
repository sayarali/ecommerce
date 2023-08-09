import 'package:ecommerce/core/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';
import '../../../../core/model/product_model.dart';

part 'products_view_model.g.dart';

class ProductsViewModel = ProducstViewModelBase with _$ProducstViewModel;

abstract class ProducstViewModelBase with Store, BaseViewModel {
  FirebaseService firebaseService = FirebaseService();
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @observable
  List<ProductModel> productsList;

  @action
  Future fetchProducts(String brandId, String categoryId, String option) async {
    if (option == "no") {
      if (categoryId == "no") {
        productsList = await firebaseService.getProducts(categoryId, brandId);
      } else {
        productsList = await firebaseService.getProducts(categoryId, brandId);
      }
    } else if (option == "new") {
      productsList = await firebaseService.getNewProducts(20, categoryId);
    } else if (option == "popular") {
      productsList =
          await firebaseService.getTopWeekViewedProducts(20, categoryId);
    }
    for (var i in productsList) {
      print(i.productName);
    }
  }
}
