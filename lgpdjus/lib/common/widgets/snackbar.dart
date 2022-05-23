import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:lgpdjus/app/core/error/failures.dart';

mixin SnackBarHandler {
  BuildContext get context;

  String extractErrorMessage(Object error) {
    if (error is String) {
      return error;
    }
    if (error is Failure) {
      return error.message;
    }

    return "Ops.. ocorreu um erro inesperado.";
  }

  void showSnackBarError(Object error) {
    final snackBar = SnackBar(
      content: Text(extractErrorMessage(error)),
    );
    asuka.showSnackBar(snackBar);
  }
}
