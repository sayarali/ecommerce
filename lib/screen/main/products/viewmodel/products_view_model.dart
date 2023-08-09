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
      List<ProductModel> a =
          await firebaseService.getProducts(categoryId, brandId);
      a.sort((a, b) => b.productCreatedTime.compareTo(a.productCreatedTime));
      if (a.length > 10) {
        productsList = a.sublist(0, 10);
      } else {
        productsList = a;
      }
    } else if (option == "popular") {
      List<ProductModel> a =
          await firebaseService.getProducts(categoryId, brandId);
      a.sort((a, b) => b.productWeeksViews.compareTo(a.productWeeksViews));
      if (a.length > 10) {
        productsList = a.sublist(0, 10);
      } else {
        productsList = a;
      }
    }
  }
}
