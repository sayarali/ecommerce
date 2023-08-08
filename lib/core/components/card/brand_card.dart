import 'package:ecommerce/core/model/brand_model.dart';
import 'package:ecommerce/core/projectstyles/project_styles.dart';
import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({Key key, this.brandModel}) : super(key: key);
  final BrandModel brandModel;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: ProjectStyles.boxDecoration,
        child: ListTile(
          leading: Image.network(
            brandModel.brandImageUrl,
            errorBuilder: (context, object, stackTrace) {
              return CircleAvatar(
                child: Icon(Icons.no_photography_rounded),
              );
            },
            width: 50,
          ),
          title: Text(brandModel.brandName),
          trailing: TextButton(
            onPressed: () {},
            child: Text("Ürünleri gör"),
          ),
        ));
  }
}
