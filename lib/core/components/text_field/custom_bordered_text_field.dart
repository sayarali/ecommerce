import 'package:flutter/material.dart';

class CustomBorderedTextField extends StatelessWidget {
  const CustomBorderedTextField(
      {Key key,
      this.onChanged,
      this.controller,
      this.labelText,
      this.errorText,
      this.error,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText})
      : super(key: key);
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String labelText;
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
          border: const OutlineInputBorder(),
          labelText: labelText,
          errorText: error == true ? errorText : null),
    );
  }
}
