import 'package:cloud_firestore/cloud_firestore.dart';

import 'basket_model.dart';

class OrderModel {
  Timestamp date;
  List<BasketModel> products;

  OrderModel({
    this.date,
    this.products,
  });
}
