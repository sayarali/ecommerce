import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/model/basket_model.dart';
import 'package:ecommerce/core/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/components/app_progress.dart';
import '../../../../core/service/firebase_service.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store, BaseViewModel {
  FirebaseService firebaseService = FirebaseService();
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {
    getBasket();
  }

  @observable
  List<BasketModel> productList;
  @observable
  double totalPrice = 0.0;

  @action
  Future getBasket() async {
    try {
      productList = await firebaseService.getBasketProducts();
      totalPrice = 0.0;
      for (var i in productList) {
        totalPrice += i.product.productPrice * i.count;
      }
    } catch (e) {
      print(e);
    }
  }

  void removeBasket(String productId) async {
    try {
      await firebaseService.removeBasket(productId);
    } catch (e) {
      print(e);
    }
  }

  Future emptyBasket() async {
    try {
      await firebaseService.emptyBasket();
    } catch (e) {
      print(e);
    }
  }

  Future addCount(BasketModel basketModel) async {
    try {
      showProgress();
      if (basketModel.count == basketModel.product.productStock) {
        ScaffoldMessenger.of(viewModelContext)
            .showSnackBar(const SnackBar(content: Text("Maksimum stok sayısı")));
      } else {
        await firebaseService.addBasket(
            basketModel.product.productId, ++basketModel.count);
      }
      await getBasket();
      closeProgress();
    } catch (e) {
      print(e);
    }
  }

  Future removeCount(BasketModel basketModel) async {
    try {
      showProgress();
      if (basketModel.count == 1) {
        removeBasket(basketModel.product.productId);
      } else {
        await firebaseService.addBasket(
            basketModel.product.productId, --basketModel.count);
      }
      await getBasket();
      closeProgress();
    } catch (e) {
      print(e);
    }
  }

  Future completeShop() async {
    try {
      if (productList.isNotEmpty) {
        OrderModel orderModel =
            OrderModel(date: Timestamp.now(), products: productList);
        await firebaseService.completeShop(orderModel, totalPrice);
        await emptyBasket();
      }
    } catch (e) {
      print(e);
    }
  }

  showProgress() => AppProgress.showProgress(viewModelContext);
  closeProgress() => AppProgress.closeProgress(viewModelContext);
}
