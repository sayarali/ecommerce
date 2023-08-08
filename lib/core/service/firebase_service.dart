import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/model/brand_model.dart';
import 'package:ecommerce/core/model/category_model.dart';
import 'package:ecommerce/core/model/product_model.dart';

class FirebaseService {
  final CollectionReference _categories =
      FirebaseFirestore.instance.collection("categories");
  final CollectionReference _products =
      FirebaseFirestore.instance.collection("products");
  final CollectionReference _brands =
      FirebaseFirestore.instance.collection("brands");

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categoryList = [];
    try {
      QuerySnapshot querySnapshot = await _categories.get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        CategoryModel categoryModel = CategoryModel.fromFirestore(doc);
        categoryList.add(categoryModel);
      }
    } catch (error) {
      throw "Kategorileri alınırken bir hata oluştu: $error";
    }
    return categoryList;
  }

  Future<List<ProductModel>> getProducts(String categoryId) async {
    try {
      DocumentReference selectedCategoryDocRef = _categories.doc(categoryId);
      QuerySnapshot querySnapshot;
      if (categoryId == "all") {
        querySnapshot = await _products.get();
      } else {
        querySnapshot = await _products
            .where("productCategory", isEqualTo: selectedCategoryDocRef)
            .get();
      }

      List<ProductModel> productList = [];

      for (QueryDocumentSnapshot e in querySnapshot.docs) {
        DocumentReference categoryDocRef =
            _categories.doc(e['productCategory'].id);
        CategoryModel categoryModel =
            CategoryModel.fromFirestore(await categoryDocRef.get());
        DocumentReference brandDocRef = _brands.doc(e['productBrand'].id);
        BrandModel brandModel =
            BrandModel.fromFirestore(await brandDocRef.get());

        ProductModel productModel = ProductModel(
            productId: e.id,
            productName: e['productName'],
            productBrand: brandModel,
            productCategory: categoryModel,
            productExplanation: e['productExplanation'],
            productImageThumbnailUrl: e['productImageThumbnailUrl'],
            productPrice: e['productPrice'],
            productStock: e['productStock'],
            productViews: e['productViews'],
            productWeeksViews: e['productWeeksViews'],
            productLike: e['productLike'],
            productCreatedTime:
                (e['productCreatedTime'] as Timestamp).toDate());

        productList.add(productModel);
      }

      return productList;
    } catch (e) {
      throw Exception("Veriler alınırken bir hata oluştu: $e");
    }
  }

  Future<List<ProductModel>> getTopWeekViewedProducts(
      int limit, String categoryId) async {
    try {
      DocumentReference selectedCategoryDocRef = _categories.doc(categoryId);
      QuerySnapshot querySnapshot;
      if (categoryId == "all") {
        querySnapshot = await _products
            .orderBy('productWeeksViews', descending: true)
            .limit(limit)
            .get();
      } else {
        querySnapshot = await _products
            .where("productCategory", isEqualTo: selectedCategoryDocRef)
            .orderBy('productWeeksViews', descending: true)
            .limit(limit)
            .get();
      }

      List<ProductModel> productList = [];

      for (QueryDocumentSnapshot e in querySnapshot.docs) {
        DocumentReference categoryDocRef =
            _categories.doc(e['productCategory'].id);
        CategoryModel categoryModel =
            CategoryModel.fromFirestore(await categoryDocRef.get());
        DocumentReference brandDocRef = _brands.doc(e['productBrand'].id);
        BrandModel brandModel =
            BrandModel.fromFirestore(await brandDocRef.get());

        ProductModel productModel = ProductModel(
            productId: e.id,
            productName: e['productName'],
            productBrand: brandModel,
            productCategory: categoryModel,
            productExplanation: e['productExplanation'],
            productImageThumbnailUrl: e['productImageThumbnailUrl'],
            productPrice: e['productPrice'],
            productStock: e['productStock'],
            productViews: e['productViews'],
            productWeeksViews: e['productWeeksViews'],
            productLike: e['productLike'],
            productCreatedTime:
                (e['productCreatedTime'] as Timestamp).toDate());

        productList.add(productModel);
      }

      return productList;
    } catch (e) {
      throw Exception("Veriler alınırken bir hata oluştu: $e");
    }
  }

  Future<List<ProductModel>> getNewProducts(
      int limit, String categoryId) async {
    try {
      DocumentReference selectedCategoryDocRef = _categories.doc(categoryId);
      QuerySnapshot querySnapshot;
      if (categoryId == "all") {
        querySnapshot = await _products
            .orderBy('productCreatedTime', descending: true)
            .limit(limit)
            .get();
      } else {
        querySnapshot = await _products
            .where("productCategory", isEqualTo: selectedCategoryDocRef)
            .orderBy('productCreatedTime', descending: true)
            .limit(limit)
            .get();
      }

      List<ProductModel> productList = [];

      for (QueryDocumentSnapshot e in querySnapshot.docs) {
        DocumentReference categoryDocRef =
            _categories.doc(e['productCategory'].id);
        CategoryModel categoryModel =
            CategoryModel.fromFirestore(await categoryDocRef.get());
        DocumentReference brandDocRef = _brands.doc(e['productBrand'].id);
        BrandModel brandModel =
            BrandModel.fromFirestore(await brandDocRef.get());

        ProductModel productModel = ProductModel(
            productId: e.id,
            productName: e['productName'],
            productBrand: brandModel,
            productCategory: categoryModel,
            productExplanation: e['productExplanation'],
            productImageThumbnailUrl: e['productImageThumbnailUrl'],
            productPrice: e['productPrice'],
            productStock: e['productStock'],
            productViews: e['productViews'],
            productWeeksViews: e['productWeeksViews'],
            productLike: e['productLike'],
            productCreatedTime:
                (e['productCreatedTime'] as Timestamp).toDate());

        productList.add(productModel);
      }

      return productList;
    } catch (e) {
      throw Exception("Veriler alınırken bir hata oluştu: $e");
    }
  }

  Future<List<BrandModel>> getBrands(String categoryId) async {
    try {
      DocumentReference selectedCategoryDocRef = _categories.doc(categoryId);
      QuerySnapshot querySnapshot;
      if (categoryId == "all") {
        querySnapshot = await _brands.get();
      } else {
        querySnapshot = await _brands
            .where("brandCategory", isEqualTo: selectedCategoryDocRef)
            .orderBy("brandName", descending: true)
            .get();
      }
      return querySnapshot.docs
          .map((e) => BrandModel.fromFirestore(e))
          .toList();
    } catch (e) {
      throw Exception("Marka verileri alınırken bir hata oluştu: $e");
    }
  }
}
