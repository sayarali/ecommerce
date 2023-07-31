import 'package:flutter/material.dart';

class AppProgress {
  static showProgress(
      BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/loading.gif',
              width: 180,
            ),
          ],
        );
      },
    );
  }
  static closeProgress(BuildContext context){
    Navigator.of(context).pop();
  }
}