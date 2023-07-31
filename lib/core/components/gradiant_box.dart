import 'package:flutter/material.dart';

class GradiantBox extends StatelessWidget {
  const GradiantBox({Key key, @required this.a, @required this.b})
      : super(key: key);
  final Color a;
  final Color b;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            a,
            b,
          ])),
    );
  }
}
