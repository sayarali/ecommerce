import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BrandModel {
  final String brandId;
  final String brandName;
  final DocumentReference brandCategory;
  final String brandImageUrl;

  BrandModel({
    @required this.brandId,
    @required this.brandName,
    @required this.brandCategory,
    @required this.brandImageUrl,
  });

  factory BrandModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return BrandModel(
      brandId: doc.id,
      brandName: data['brandName'],
      brandCategory: data['brandCategory'],
      brandImageUrl: data['brandImageUrl'],
    );
  }
}
