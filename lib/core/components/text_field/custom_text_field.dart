import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key key,
      this.onChanged,
      this.controller,
      this.hintText,
      this.errorText,
      this.error,
      this.prefixIcon,
      this.suffixIcon, this.obscureText})
      : super(key: key);
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String hintText;
  final String errorText;
  final bool error;
  final bool obscureText;
  final Icon prefixIcon;
  final IconButton suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          border: InputBorder.none,
          hintText: hintText,
          errorText: error == true ? errorText : null),
    );
  }
}
