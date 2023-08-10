// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteViewModel on FavoriteViewModelBase, Store {
  final _$productListAtom = Atom(
    name: 'FavoriteViewModelBase.productList',
  );

  @override
  List<ProductModel> get productsList {
    _$productListAtom.reportRead();
    return super.productsList;
  }

  @override
  set productsList(List<ProductModel> value) {
    _$productListAtom.reportWrite(value, super.productsList, () {
      super.productsList = value;
    });
  }

  final _$fetchFavoriteListAsyncAction = AsyncAction(
    'FavoriteViewModelBase.fetchFavoriteList',
  );

  @override
  Future<dynamic> fetchFavoriteList() {
    return _$fetchFavoriteListAsyncAction.run(() => super.fetchFavoriteList());
  }

  @override
  String toString() {
    return '''
productList: ${productsList}
    ''';
  }
}
