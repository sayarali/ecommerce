// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductDetailsViewModel on ProductDetailsViewModelBase, Store {
  final _$imagesUrlsAtom = Atom(
    name: 'ProductDetailsViewModelBase.imagesUrls',
  );

  @override
  List<String> get imagesUrls {
    _$imagesUrlsAtom.reportRead();
    return super.imagesUrls;
  }

  @override
  set imagesUrls(List<String> value) {
    _$imagesUrlsAtom.reportWrite(value, super.imagesUrls, () {
      super.imagesUrls = value;
    });
  }

  final _$getImagesUrlAsyncAction = AsyncAction(
    'ProductDetailsViewModelBase.getImagesUrl',
  );

  @override
  Future<dynamic> getImagesUrl(String productId) {
    return _$getImagesUrlAsyncAction.run(() => super.getImagesUrl(productId));
  }

  @override
  String toString() {
    return '''
imagesUrls: ${imagesUrls}
    ''';
  }
}
