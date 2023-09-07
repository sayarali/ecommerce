import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:ecommerce/core/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/model/category_model.dart';

part 'categories_view_model.g.dart';

class CategoriesViewModel = CategoriesViewModelBase with _$CategoriesViewModel;

abstract class CategoriesViewModelBase with Store, BaseViewModel {
  FirebaseService firebaseService = FirebaseService();
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {
    fetchCategoryList();
  }

  @observable
  List<CategoryModel> categoryList;
  @action
  Future fetchCategoryList() async {
    try {
      categoryList = await firebaseService.getCategories();
    } catch (e) {
      print(e);
    }
  }
}
