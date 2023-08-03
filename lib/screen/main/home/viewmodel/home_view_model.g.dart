// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on HomeViewModelBase, Store {
  final _$displayNameAtom = Atom(
    name: 'HomeViewModelBase.displayName',
  );

  @override
  String get displayName {
    _$displayNameAtom.reportRead();
    return super.displayName;
  }

  @override
  set displayName(String value) {
    _$displayNameAtom.reportWrite(value, super.displayName, () {
      super.displayName = value;
    });
  }

  final _$profilePhotoUrlAtom = Atom(
    name: 'HomeViewModelBase.profilePhotoUrl',
  );

  @override
  String get profilePhotoUrl {
    _$profilePhotoUrlAtom.reportRead();
    return super.profilePhotoUrl;
  }

  @override
  set profilePhotoUrl(String value) {
    _$profilePhotoUrlAtom.reportWrite(value, super.profilePhotoUrl, () {
      super.profilePhotoUrl = value;
    });
  }

  final _$getUserAsyncAction = AsyncAction(
    'HomeViewModelBase.getUser',
  );

  @override
  Future getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  @override
  String toString() {
    return '''
displayName: ${displayName},
profilePhotoUrl: ${profilePhotoUrl}
    ''';
  }
}
