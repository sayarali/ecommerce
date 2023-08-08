import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  final String categoryId;
  final String categoryName;

  CategoryModel({
    @required this.categoryId,
    @required this.categoryName,
  });

  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return CategoryModel(
      categoryId: doc.id,
      categoryName: data['categoryName'] ?? '',
    );
  }
}
