// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccountViewModel on AccountViewModelBase, Store {
  final _$userAtom = Atom(
    name: 'AccountViewModelBase.user',
  );

  @override
  User get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$getUserAsyncAction = AsyncAction(
    'AccountViewModelBase.getUser',
  );

  @override
  Future getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
