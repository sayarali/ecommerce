import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/model/product_model.dart';

part 'favorite_view_model.g.dart';

class FavoriteViewModel = FavoriteViewModelBase with _$FavoriteViewModel;

abstract class FavoriteViewModelBase with Store, BaseViewModel {
  FirebaseService firebaseService = FirebaseService();
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {
    fetchFavoriteList();
  }

  @observable
  List<ProductModel> productsList;

  @action
  Future fetchFavoriteList() async {
    try {
      productsList = await firebaseService.getFavoriteProducts();
    } catch (e) {
      print(e);
    }
  }
}
