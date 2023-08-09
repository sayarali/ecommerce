// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoriesViewModel on CategoriesViewModelBase, Store {
  final _$categoryListAtom = Atom(
    name: 'CategoriesViewModelBase.categoryList',
  );

  @override
  List<CategoryModel> get categoryList {
    _$categoryListAtom.reportRead();
    return super.categoryList;
  }

  @override
  set categoryList(List<CategoryModel> value) {
    _$categoryListAtom.reportWrite(value, super.categoryList, () {
      super.categoryList = value;
    });
  }

  final _$fetchCategoryListAsyncAction = AsyncAction(
    'CategoriesViewModelBase.fetchCategoryList',
  );

  @override
  Future<dynamic> fetchCategoryList() {
    return _$fetchCategoryListAsyncAction.run(() => super.fetchCategoryList());
  }

  @override
  String toString() {
    return '''
categoryList: ${categoryList}
    ''';
  }
}
