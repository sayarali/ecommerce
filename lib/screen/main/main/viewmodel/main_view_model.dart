import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/constants/navigation/navigation_constants.dart';
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

  TextEditingController searchController = TextEditingController();

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
  List<ProductModel> allProducts;
  @observable
  List<ProductModel> searchedList = [];
  @override
  void init() {
    fetchCategoryList();
    fetchPopularProductsList(selectedCategory);
    fetchNewProductsList(selectedCategory);
    fetchBrandsList(selectedCategory);
    getAllProducts();
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
      List<ProductModel> a =
          await firebaseService.getProducts(selectedCategory, "no");
      a.sort((a, b) => b.productWeeksViews.compareTo(a.productWeeksViews));
      if (a.length > 10) {
        popularProductsList = a.sublist(0, 10);
      } else {
        popularProductsList = a;
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future fetchNewProductsList(String categoryId) async {
    try {
      List<ProductModel> a =
          await firebaseService.getProducts(selectedCategory, "no");
      a.sort((a, b) => b.productCreatedTime.compareTo(a.productCreatedTime));
      if (a.length > 10) {
        newProductsList = a.sublist(0, 10);
      } else {
        newProductsList = a;
      }
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

  void goToAllPopularProducts() {
    Map<String, dynamic> data = Map();
    data["title"] = "Popüler Ürünler";
    data["option"] = "popular";
    data["category"] = selectedCategory;
    data["brand"] = "no";
    navigation.navigateToPage(
        path: NavigationConstants.PRODUCTS_VIEW, data: data);
  }

  void goToNewProducts() {
    Map<String, dynamic> data = Map();
    data["title"] = "Yeni Ürünler";
    data["option"] = "new";
    data["category"] = selectedCategory;
    data["brand"] = "no";
    navigation.navigateToPage(
        path: NavigationConstants.PRODUCTS_VIEW, data: data);
  }

  Future getAllProducts() async {
    allProducts = await firebaseService.getProducts("all", "no");
  }

  @action
  Future searchProducts(String searchString) async {
    searchedList = allProducts
        .where((element) =>
            element.productName
                .toLowerCase()
                .contains(searchString.toLowerCase()) ||
            element.productBrand.brandName
                .toLowerCase()
                .contains(searchString) ||
            element.productCategory.categoryName
                .toLowerCase()
                .contains(searchString))
        .toList();
  }
}
