// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProducstViewModel on ProducstViewModelBase, Store {
  final _$productsListAtom = Atom(
    name: 'ProducstViewModelBase.productsList',
  );

  @override
  List<ProductModel> get productsList {
    _$productsListAtom.reportRead();
    return super.productsList;
  }

  @override
  set productsList(List<ProductModel> value) {
    _$productsListAtom.reportWrite(value, super.productsList, () {
      super.productsList = value;
    });
  }

  final _$fetchProductsAsyncAction = AsyncAction(
    'ProducstViewModelBase.fetchProducts',
  );

  @override
  Future fetchProducts(String brandId, String categoryId, String option) {
    return _$fetchProductsAsyncAction
        .run(() => super.fetchProducts(brandId, categoryId, option));
  }

  @override
  String toString() {
    return '''
productsList: ${productsList}
    ''';
  }
}
