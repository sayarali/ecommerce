import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'categories_view_model.g.dart';

class CategoriesViewModel = CategoriesViewModelBase with _$CategoriesViewModel;

abstract class CategoriesViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}
}
