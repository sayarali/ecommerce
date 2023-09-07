import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget header;
  final List<Widget> children;
  const CustomBottomSheet(
      {Key key, @required this.header, @required this.children})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            header,
            const Divider(),
            ...children,
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
