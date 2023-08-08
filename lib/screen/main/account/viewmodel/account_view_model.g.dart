// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccountViewModel on AccountViewModelBase, Store {
  final _$userModelAtom = Atom(
    name: 'AccountViewModelBase.userModel',
  );

  @override
  UserModel get userModel {
    _$userModelAtom.reportRead();
    return super.userModel;
  }

  @override
  set userModel(UserModel value) {
    _$userModelAtom.reportWrite(value, super.userModel, () {
      super.userModel = value;
    });
  }

  final _$emailVerifiedAtom = Atom(
    name: 'AccountViewModelBase.emailVerified',
  );

  @override
  bool get emailVerified {
    _$emailVerifiedAtom.reportRead();
    return super.emailVerified;
  }

  @override
  set emailVerified(bool value) {
    _$emailVerifiedAtom.reportWrite(value, super.emailVerified, () {
      super.emailVerified = value;
    });
  }

  final _$allNotificationsAtom =
      Atom(name: 'AccountViewModelBase.allNotifications');

  @override
  bool get allNotifications {
    _$allNotificationsAtom.reportRead();
    return super.allNotifications;
  }

  @override
  set allNotifications(bool value) {
    _$allNotificationsAtom.reportWrite(value, super.allNotifications, () {
      super.allNotifications = value;
    });
  }

  final _$fetchUserDataAsyncAction = AsyncAction(
    'AccountViewModelBase.fetchUserData',
  );

  @override
  Future<void> fetchUserData() {
    return _$fetchUserDataAsyncAction.run(() => super.fetchUserData());
  }

  @override
  String toString() {
    return '''
userModel: ${userModel},
emailVerified: ${emailVerified},
allNotifications: ${allNotifications}
    ''';
  }
}
