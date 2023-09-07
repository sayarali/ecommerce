import 'package:ecommerce/core/service/firebase_service.dart';
import 'package:ecommerce/core/service/firebase_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_view_model.dart';

part 'product_details_view_model.g.dart';

class ProductDetailsViewModel = ProductDetailsViewModelBase
    with _$ProductDetailsViewModel;

abstract class ProductDetailsViewModelBase with Store, BaseViewModel {
  FirebaseService firebaseService = FirebaseService();
  FirebaseStorageService firebaseStorageService = FirebaseStorageService();
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @observable
  List<String> imagesUrls;
  @action
  Future getImagesUrl(String productId) async {
    try {
      imagesUrls = await firebaseStorageService.getProductImagesURLs(productId);
    } catch (e) {
      print(e);
    }
  }
}
