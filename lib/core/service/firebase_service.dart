import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/core/model/basket_model.dart';
import 'package:ecommerce/core/model/brand_model.dart';
import 'package:ecommerce/core/model/category_model.dart';
import 'package:ecommerce/core/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/order_model.dart';

class FirebaseService {
  final CollectionReference _categories =
      FirebaseFirestore.instance.collection("categories");
  final CollectionReference _products =
      FirebaseFirestore.instance.collection("products");
  final CollectionReference _brands =
      FirebaseFirestore.instance.collection("brands");
  final CollectionReference _favorites = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("favorite_products");
  final CollectionReference _basket = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("basket");
  final CollectionReference _myOrders = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection("myOrders");

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

  Future<List<ProductModel>> getProducts(
      String categoryId, String brandId) async {
    try {
      QuerySnapshot querySnapshot;
      if (brandId == "no") {
        if (categoryId == "all") {
          querySnapshot = await _products.get();
        } else {
          DocumentReference selectedCategoryDocRef =
              _categories.doc(categoryId);
          querySnapshot = await _products
              .where("productCategory", isEqualTo: selectedCategoryDocRef)
              .get();
        }
      } else {
        DocumentReference selectedBrandDocRef = _brands.doc(brandId);
        querySnapshot = await _products
            .where("productBrand", isEqualTo: selectedBrandDocRef)
            .get();
      }

      QuerySnapshot favQuery = await _favorites.get();
      List<ProductModel> productList = [];

      for (QueryDocumentSnapshot e in querySnapshot.docs) {
        DocumentReference categoryDocRef =
            _categories.doc(e['productCategory'].id);
        CategoryModel categoryModel =
            CategoryModel.fromFirestore(await categoryDocRef.get());
        DocumentReference brandDocRef = _brands.doc(e['productBrand'].id);
        BrandModel brandModel =
            BrandModel.fromFirestore(await brandDocRef.get());
        ProductModel productModel;
        if (favQuery.docs.length > 0) {
          for (QueryDocumentSnapshot fav in favQuery.docs) {
            if (e["productId"] == fav["productId"]) {
              productModel = ProductModel(
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
                    (e['productCreatedTime'] as Timestamp).toDate(),
                isLike: true,
              );
              break;
            } else {
              productModel = ProductModel(
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
                    (e['productCreatedTime'] as Timestamp).toDate(),
                isLike: false,
              );
            }
          }
        } else {
          productModel = ProductModel(
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
            productCreatedTime: (e['productCreatedTime'] as Timestamp).toDate(),
            isLike: false,
          );
        }

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

  Future<void> addFavorite(String productId) async {
    try {
      Map<String, String> data = {};
      data["productId"] = productId;
      await _favorites.doc(productId).set(data);
    } catch (e) {
      throw Exception("Ürün eklenirken bir hata oluştu: $e");
    }
  }

  Future<void> removeFavorite(String productId) async {
    try {
      await _favorites.doc(productId).delete();
    } catch (e) {
      throw Exception("Ürün silinirken bir hata oluştu: $e");
    }
  }

  Future<List<ProductModel>> getFavoriteProducts() async {
    try {
      QuerySnapshot querySnapshot = await _favorites.get();
      List<ProductModel> productsList = [];
      for (QueryDocumentSnapshot fav in querySnapshot.docs) {
        DocumentSnapshot productSnapshot = await _products.doc(fav.id).get();
        DocumentReference categoryDocRef =
            _categories.doc(productSnapshot['productCategory'].id);
        CategoryModel categoryModel =
            CategoryModel.fromFirestore(await categoryDocRef.get());
        DocumentReference brandDocRef =
            _brands.doc(productSnapshot['productBrand'].id);
        BrandModel brandModel =
            BrandModel.fromFirestore(await brandDocRef.get());
        ProductModel productModel = ProductModel(
          productId: productSnapshot.id,
          productName: productSnapshot['productName'],
          productBrand: brandModel,
          productCategory: categoryModel,
          productExplanation: productSnapshot['productExplanation'],
          productImageThumbnailUrl: productSnapshot['productImageThumbnailUrl'],
          productPrice: productSnapshot['productPrice'],
          productStock: productSnapshot['productStock'],
          productViews: productSnapshot['productViews'],
          productWeeksViews: productSnapshot['productWeeksViews'],
          productLike: productSnapshot['productLike'],
          productCreatedTime:
              (productSnapshot['productCreatedTime'] as Timestamp).toDate(),
          isLike: true,
        );
        productsList.add(productModel);
      }
      return productsList;
    } catch (e) {
      throw Exception("Favori ürünler alınırken bir hata oluştu: $e");
    }
  }

  Future<void> addBasket(String productId) async {
    try {
      Map<String, dynamic> data = {};
      data["productId"] = productId;
      data["count"] = 1;
      await _basket.doc(productId).set(data);
    } catch (e) {
      throw Exception("Sepete ürün eklenirken bir hata oluştu: $e");
    }
  }

  Future<void> removeBasket(String productId) async {
    try {
      await _basket.doc(productId).delete();
    } catch (e) {
      throw Exception("Sepetten ürün silinrken bir hata oluştu: $e");
    }
  }

  Future<void> emptyBasket() async {
    try {
      QuerySnapshot querySnapshot = await _basket.get();
      for (var document in querySnapshot.docs) {
        document.reference.delete();
      }
    } catch (e) {
      throw Exception("Sepet silinirken bir hata oluştu: $e");
    }
  }

  Future<List<BasketModel>> getBasketProducts() async {
    try {
      QuerySnapshot querySnapshot = await _basket.get();
      List<BasketModel> productsList = [];
      for (QueryDocumentSnapshot basket in querySnapshot.docs) {
        DocumentSnapshot productSnapshot = await _products.doc(basket.id).get();
        DocumentReference categoryDocRef =
            _categories.doc(productSnapshot['productCategory'].id);
        CategoryModel categoryModel =
            CategoryModel.fromFirestore(await categoryDocRef.get());
        DocumentReference brandDocRef =
            _brands.doc(productSnapshot['productBrand'].id);
        BrandModel brandModel =
            BrandModel.fromFirestore(await brandDocRef.get());
        ProductModel productModel = ProductModel(
          productId: productSnapshot.id,
          productName: productSnapshot['productName'],
          productBrand: brandModel,
          productCategory: categoryModel,
          productExplanation: productSnapshot['productExplanation'],
          productImageThumbnailUrl: productSnapshot['productImageThumbnailUrl'],
          productPrice: productSnapshot['productPrice'],
          productStock: productSnapshot['productStock'],
          productViews: productSnapshot['productViews'],
          productWeeksViews: productSnapshot['productWeeksViews'],
          productLike: productSnapshot['productLike'],
          productCreatedTime:
              (productSnapshot['productCreatedTime'] as Timestamp).toDate(),
        );
        BasketModel basketModel = BasketModel(
          product: productModel,
          count: basket["count"],
        );
        productsList.add(basketModel);
      }
      return productsList;
    } catch (e) {
      throw Exception("Sepetteki ürünler alınırken bir hata oluştu: $e");
    }
  }

  Future<void> completeShop(OrderModel orderModel, double totalPrice) async {
    try {
      await _myOrders.add({
        'totalPrice': totalPrice,
        'date': orderModel.date,
        'products': orderModel.products.map((product) {
          return {
            'product': {
              'id': product.product.productId,
              'price': product.product.productPrice,
            },
            'count': product.count,
          };
        }).toList(),
      });
    } catch (e) {
      throw Exception("Alışveriş tamamlanırken bir hata oluştu: $e");
    }
  }

  Future<List<ProductModel>> searchInProducts(String searchString) async {
    Future.delayed(const Duration(seconds: 1));
    try {
      QuerySnapshot querySnapshot = await _products
          .where('productName', isGreaterThanOrEqualTo: searchString)
          .where('productName', isLessThan: '${searchString}z')
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      QuerySnapshot favQuery = await _favorites.get();
      List<ProductModel> productList = [];
      for (var doc in documents) {
        DocumentReference categoryDocRef =
            _categories.doc(doc['productCategory'].id);
        CategoryModel categoryModel =
            CategoryModel.fromFirestore(await categoryDocRef.get());
        DocumentReference brandDocRef = _brands.doc(doc['productBrand'].id);
        BrandModel brandModel =
            BrandModel.fromFirestore(await brandDocRef.get());
        ProductModel productModel;
        if (favQuery.docs.length > 0) {
          for (QueryDocumentSnapshot fav in favQuery.docs) {
            if (doc["productId"] == fav["productId"]) {
              productModel = ProductModel(
                productId: doc.id,
                productName: doc['productName'],
                productBrand: brandModel,
                productCategory: categoryModel,
                productExplanation: doc['productExplanation'],
                productImageThumbnailUrl: doc['productImageThumbnailUrl'],
                productPrice: doc['productPrice'],
                productStock: doc['productStock'],
                productViews: doc['productViews'],
                productWeeksViews: doc['productWeeksViews'],
                productLike: doc['productLike'],
                productCreatedTime:
                    (doc['productCreatedTime'] as Timestamp).toDate(),
                isLike: true,
              );
              break;
            } else {
              productModel = ProductModel(
                productId: doc.id,
                productName: doc['productName'],
                productBrand: brandModel,
                productCategory: categoryModel,
                productExplanation: doc['productExplanation'],
                productImageThumbnailUrl: doc['productImageThumbnailUrl'],
                productPrice: doc['productPrice'],
                productStock: doc['productStock'],
                productViews: doc['productViews'],
                productWeeksViews: doc['productWeeksViews'],
                productLike: doc['productLike'],
                productCreatedTime:
                    (doc['productCreatedTime'] as Timestamp).toDate(),
                isLike: false,
              );
            }
          }
        } else {
          productModel = ProductModel(
            productId: doc.id,
            productName: doc['productName'],
            productBrand: brandModel,
            productCategory: categoryModel,
            productExplanation: doc['productExplanation'],
            productImageThumbnailUrl: doc['productImageThumbnailUrl'],
            productPrice: doc['productPrice'],
            productStock: doc['productStock'],
            productViews: doc['productViews'],
            productWeeksViews: doc['productWeeksViews'],
            productLike: doc['productLike'],
            productCreatedTime:
                (doc['productCreatedTime'] as Timestamp).toDate(),
            isLike: false,
          );
        }

        productList.add(productModel);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
