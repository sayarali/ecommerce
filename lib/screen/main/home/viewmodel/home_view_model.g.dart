// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on HomeViewModelBase, Store {
  final _$productListAtom = Atom(
    name: 'HomeViewModelBase.productList',
  );

  @override
  List<BasketModel> get productList {
    _$productListAtom.reportRead();
    return super.productList;
  }

  @override
  set productList(List<BasketModel> value) {
    _$productListAtom.reportWrite(value, super.productList, () {
      super.productList = value;
    });
  }

  final _$getBasketAsyncAction = AsyncAction(
    'HomeViewModelBase.getBasket',
  );

  @override
  Future<dynamic> getBasket() {
    return _$getBasketAsyncAction.run(() => super.getBasket());
  }

  @override
  String toString() {
    return '''
productList: ${productList}
    ''';
  }
}
