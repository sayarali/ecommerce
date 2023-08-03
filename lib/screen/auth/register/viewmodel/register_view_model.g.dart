// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterViewModel on RegisterViewModelBase, Store {
  final _$emailErrorAtom = Atom(
    name: 'RegisterViewModelBase.emailError',
  );

  @override
  bool get emailError {
    _$emailErrorAtom.reportRead();
    return super.emailError;
  }

  @override
  set emailError(bool value) {
    _$emailErrorAtom.reportWrite(value, super.emailError, () {
      super.emailError = value;
    });
  }

  final _$nameErrorAtom = Atom(
    name: 'RegisterViewModelBase.nameError',
  );

  @override
  bool get nameError {
    _$nameErrorAtom.reportRead();
    return super.nameError;
  }

  @override
  set nameError(bool value) {
    _$nameErrorAtom.reportWrite(value, super.nameError, () {
      super.nameError = value;
    });
  }

  final _$lastNameErrorAtom = Atom(
    name: 'RegisterViewModelBase.lastNameError',
  );

  @override
  bool get lastNameError {
    _$lastNameErrorAtom.reportRead();
    return super.lastNameError;
  }

  @override
  set lastNameError(bool value) {
    _$lastNameErrorAtom.reportWrite(value, super.lastNameError, () {
      super.lastNameError = value;
    });
  }

  final _$passwordErrorAtom = Atom(
    name: 'RegisterViewModelBase.passwordError',
  );

  @override
  bool get passwordError {
    _$passwordErrorAtom.reportRead();
    return super.passwordError;
  }

  @override
  set passwordError(bool value) {
    _$passwordErrorAtom.reportWrite(value, super.passwordError, () {
      super.passwordError = value;
    });
  }

  final _$passwordCheckErrorAtom = Atom(
    name: 'RegisterViewModelBase.passwordCheckError',
  );

  @override
  bool get passwordCheckError {
    _$passwordCheckErrorAtom.reportRead();
    return super.passwordCheckError;
  }

  @override
  set passwordCheckError(bool value) {
    _$passwordCheckErrorAtom.reportWrite(value, super.passwordCheckError, () {
      super.passwordCheckError = value;
    });
  }

  final _$passwordVisibilityAtom = Atom(
    name: 'RegisterViewModelBase.passwordVisibility',
  );

  @override
  bool get passwordVisibility {
    _$passwordVisibilityAtom.reportRead();
    return super.passwordVisibility;
  }

  @override
  set passwordVisibility(bool value) {
    _$passwordVisibilityAtom.reportWrite(value, super.passwordVisibility, () {
      super.passwordVisibility = value;
    });
  }

  final _$passwordCheckVisibilityAtom = Atom(
    name: 'RegisterViewModelBase.passwordCheckVisibility',
  );

  @override
  bool get passwordCheckVisibility {
    _$passwordCheckVisibilityAtom.reportRead();
    return super.passwordCheckVisibility;
  }

  @override
  set passwordCheckVisibility(bool value) {
    _$passwordCheckVisibilityAtom
        .reportWrite(value, super.passwordCheckVisibility, () {
      super.passwordCheckVisibility = value;
    });
  }

  @override
  String toString() {
    return '''
emailError: ${emailError},
nameError: ${nameError},
lastNameError: ${lastNameError},
passwordError: ${passwordError},
passwordCheckError: ${passwordCheckError},
passwordVisibility: ${passwordVisibility},
passwordCheckVisibility: ${passwordCheckVisibility}
    ''';
  }
}
