import 'package:ecommerce/core/model/brand_model.dart';
import 'package:ecommerce/core/projectstyles/project_styles.dart';
import 'package:flutter/material.dart';

import '../../constants/navigation/navigation_constants.dart';
import '../../init/navigation/navigation_service.dart';

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
              return const CircleAvatar(
                child: Icon(Icons.no_photography_rounded),
              );
            },
            width: 50,
          ),
          title: Text(brandModel.brandName),
          trailing: TextButton(
            onPressed: () {
              Map<String, dynamic> data = {};
              data["title"] = brandModel.brandName;
              data["option"] = "no";
              data["category"] = "no";
              data["brand"] = brandModel.brandId;
              NavigationService.instance.navigateToPage(
                  path: NavigationConstants.PRODUCTS_VIEW, data: data);
            },
            child: const Text("Ürünleri gör"),
          ),
        ));
  }
}
