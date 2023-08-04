import 'package:flutter/material.dart';

class ProjectStyles {
  static BoxDecoration get boxDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              blurStyle: BlurStyle.outer),
        ],
      );
}
