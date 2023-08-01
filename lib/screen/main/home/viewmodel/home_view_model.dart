import 'package:ecommerce/core/base/model/base_view_model.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {

  }
  @override
  void init() {

  }

}
