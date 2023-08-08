import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/model/brand_model.dart';
import 'package:ecommerce/core/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/model/category_model.dart';
import '../../../../core/model/product_model.dart';

part 'main_view_model.g.dart';

class MainViewModel = MainViewModelBase with _$MainViewModel;

abstract class MainViewModelBase with Store, BaseViewModel {
  FirebaseService firebaseService = FirebaseService();
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @observable
  List<CategoryModel> categoryList = [];
  @observable
  String selectedCategory = "all";
  @observable
  List<ProductModel> popularProductsList;
  @observable
  List<ProductModel> newProductsList;
  @observable
  List<BrandModel> brandsList;

  @observable
  bool isSearching = false;
  @observable
  List<String> searchedList = [
    "macbook air",
    "iphone 14",
    "klima",
    "macbook air",
    "iphone 14",
    "klima",
    "macbook air",
    "iphone 14",
    "klima",
    "macbook air",
    "iphone 14",
    "klima",
    "macbook air",
    "iphone 14",
    "son"
  ];
  @override
  void init() {
    fetchCategoryList();
    fetchPopularProductsList(selectedCategory);
    fetchNewProductsList(selectedCategory);
    fetchBrandsList(selectedCategory);
  }

  @action
  Future fetchCategoryList() async {
    try {
      categoryList = await firebaseService.getCategories();
    } catch (e) {
      print(e);
    }
  }

  @action
  void selectCategory(String categoryName) {
    selectedCategory = categoryName;
    fetchPopularProductsList(selectedCategory);
    fetchNewProductsList(selectedCategory);
    fetchBrandsList(selectedCategory);
  }

  @action
  void clearSelection() {
    selectedCategory = '';
  }

  @action
  void changeSearch() {
    isSearching = !isSearching;
  }

  @action
  Future fetchPopularProductsList(String categoryId) async {
    try {
      popularProductsList =
          await firebaseService.getTopWeekViewedProducts(10, selectedCategory);
    } catch (e) {
      print(e);
    }
  }

  @action
  Future fetchNewProductsList(String categoryId) async {
    try {
      newProductsList =
          await firebaseService.getNewProducts(10, selectedCategory);
    } catch (e) {
      print(e);
    }
  }

  @action
  Future fetchBrandsList(String categoryId) async {
    try {
      brandsList = await firebaseService.getBrands(selectedCategory);
    } catch (e) {
      print(e);
    }
  }
}
