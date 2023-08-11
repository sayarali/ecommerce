// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainViewModel on MainViewModelBase, Store {
  final _$categoryListAtom = Atom(
    name: 'MainViewModelBase.categoryList',
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

  final _$selectedCategoryAtom = Atom(
    name: 'MainViewModelBase.selectedCategory',
  );

  @override
  String get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(String value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  final _$popularProductsListAtom = Atom(
    name: 'MainViewModelBase.popularProductsList',
  );

  @override
  List<ProductModel> get popularProductsList {
    _$popularProductsListAtom.reportRead();
    return super.popularProductsList;
  }

  @override
  set popularProductsList(List<ProductModel> value) {
    _$popularProductsListAtom.reportWrite(value, super.popularProductsList, () {
      super.popularProductsList = value;
    });
  }

  final _$newProductsListAtom = Atom(
    name: 'MainViewModelBase.newProductsList',
  );

  @override
  List<ProductModel> get newProductsList {
    _$newProductsListAtom.reportRead();
    return super.newProductsList;
  }

  @override
  set newProductsList(List<ProductModel> value) {
    _$newProductsListAtom.reportWrite(value, super.newProductsList, () {
      super.newProductsList = value;
    });
  }

  final _$brandsListAtom = Atom(
    name: 'MainViewModelBase.brandsList',
  );

  @override
  List<BrandModel> get brandsList {
    _$brandsListAtom.reportRead();
    return super.brandsList;
  }

  @override
  set brandsList(List<BrandModel> value) {
    _$brandsListAtom.reportWrite(value, super.brandsList, () {
      super.brandsList = value;
    });
  }

  final _$isSearchingAtom = Atom(
    name: 'MainViewModelBase.isSearching',
  );

  @override
  bool get isSearching {
    _$isSearchingAtom.reportRead();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.reportWrite(value, super.isSearching, () {
      super.isSearching = value;
    });
  }

  final _$searchedListAtom = Atom(
    name: 'MainViewModelBase.searchedList',
  );

  @override
  List<ProductModel> get searchedList {
    _$searchedListAtom.reportRead();
    return super.searchedList;
  }

  @override
  set searchedList(List<ProductModel> value) {
    _$searchedListAtom.reportWrite(value, super.searchedList, () {
      super.searchedList = value;
    });
  }

  final _$fetchCategoryListAsyncAction = AsyncAction(
    'MainViewModelBase.fetchCategoryList',
  );

  @override
  Future<dynamic> fetchCategoryList() {
    return _$fetchCategoryListAsyncAction.run(() => super.fetchCategoryList());
  }

  final _$fetchPopularProductsListAsyncAction = AsyncAction(
    'MainViewModelBase.fetchPopularProductsList',
  );

  @override
  Future<dynamic> fetchPopularProductsList(String categoryId) {
    return _$fetchPopularProductsListAsyncAction
        .run(() => super.fetchPopularProductsList(categoryId));
  }

  final _$fetchNewProductsListAsyncAction = AsyncAction(
    'MainViewModelBase.fetchNewProductsList',
  );

  @override
  Future<dynamic> fetchNewProductsList(String categoryId) {
    return _$fetchNewProductsListAsyncAction
        .run(() => super.fetchNewProductsList(categoryId));
  }

  final _$fetchBrandsListAsyncAction = AsyncAction(
    'MainViewModelBase.fetchBrandsList',
  );

  @override
  Future<dynamic> fetchBrandsList(String categoryId) {
    return _$fetchBrandsListAsyncAction
        .run(() => super.fetchBrandsList(categoryId));
  }

  final _$searchProductsAsyncAction = AsyncAction(
    'MainViewModelBase.searchProducts',
  );

  @override
  Future<dynamic> searchProducts(String searchString) {
    return _$searchProductsAsyncAction
        .run(() => super.searchProducts(searchString));
  }

  final _$MainViewModelBaseActionController = ActionController(
    name: 'MainViewModelBase',
  );

  @override
  void selectCategory(String categoryName) {
    final _$actionInfo = _$MainViewModelBaseActionController.startAction(
        name: 'MainViewModelBase.selectCategory');
    try {
      return super.selectCategory(categoryName);
    } finally {
      _$MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSelection() {
    final _$actionInfo = _$MainViewModelBaseActionController.startAction(
        name: 'MainViewModelBase.clearSelection');
    try {
      return super.clearSelection();
    } finally {
      _$MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSearch() {
    final _$actionInfo = _$MainViewModelBaseActionController.startAction(
        name: 'MainViewModelBase.changeSearch');
    try {
      return super.changeSearch();
    } finally {
      _$MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categoryList: ${categoryList},
selectedCategory: ${selectedCategory},
popularProductsList: ${popularProductsList},
newProductsList: ${newProductsList},
brandsList: ${brandsList},
isSearching: ${isSearching},
searchedList: ${searchedList}
    ''';
  }
}
