import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/model/brand_model.dart';
import 'package:ecommerce/core/model/category_model.dart';

class ProductModel {
  String productId;
  String productName;
  BrandModel productBrand;
  CategoryModel productCategory;
  String productExplanation;
  String productImageThumbnailUrl;
  dynamic productPrice;
  int productStock;
  int productViews;
  int productWeeksViews;
  int productLike;
  DateTime productCreatedTime;

  ProductModel({
    this.productId,
    this.productName,
    this.productBrand,
    this.productCategory,
    this.productExplanation,
    this.productImageThumbnailUrl,
    this.productPrice,
    this.productStock,
    this.productViews,
    this.productWeeksViews,
    this.productLike,
    this.productCreatedTime,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductModel(
      productId: snapshot.id,
      productName: data['productName'],
      productBrand: data['productBrand'],
      productCategory: data['productCategory'],
      productExplanation: data['productExplanation'],
      productImageThumbnailUrl: data['productImageThumbnailUrl'],
      productPrice: data['productPrice'],
      productStock: data['productStock'],
      productViews: data['productViews'],
      productWeeksViews: data['productWeeksViews'],
      productLike: data['productLike'],
      productCreatedTime: (data['productCreatedTime'] as Timestamp).toDate(),
    );
  }
}
