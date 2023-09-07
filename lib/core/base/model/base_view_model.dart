import 'package:ecommerce/core/init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';

abstract class BaseViewModel {
  BuildContext viewModelContext;
  NavigationService navigation = NavigationService.instance;
  void setContext(BuildContext context);
  void init();
}
