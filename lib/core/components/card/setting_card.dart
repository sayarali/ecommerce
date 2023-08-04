import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  const SettingCard(
      {Key key, @required this.imageAsset, @required this.label, this.onTap})
      : super(key: key);
  final String imageAsset;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                blurStyle: BlurStyle.outer),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Image.asset(
                imageAsset,
                height: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(label)
            ],
          ),
        ),
      ),
    );
  }
}
