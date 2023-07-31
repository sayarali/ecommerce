// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginViewModel on LoginViewModelBase, Store {
  final _$emailErrorAtom =
      Atom(name: 'LoginViewModelBase.emailError',);

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

  final _$passwordErrorAtom =
      Atom(name: 'LoginViewModelBase.passwordError',);

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

  final _$passwordVisibilityAtom =
      Atom(name: 'LoginViewModelBase.passwordVisibility',);

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

  @override
  String toString() {
    return '''
emailError: ${emailError},
passwordError: ${passwordError},
passwordVisibility: ${passwordVisibility}
    ''';
  }
}
