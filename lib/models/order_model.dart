import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:netmarket_flutter/models/product.dart';

class OrderModel {
  final double totalPrice;
  final List<Product> products;
  final DateTime orderDate;

  OrderModel({
    required this.totalPrice,
    required this.products,
    required this.orderDate,
  });

  @override
  String toString() {
    return 'OrderModel{totalPrice: $totalPrice, products: $products, orderDate: $orderDate}';
  }

  Map<String, dynamic> toMap(int id) {
    List<Map<String, dynamic>> productsMap =
    products.map((item) => item.toMap()).toList();
    return {
      'id': id,
      'totalPrice': totalPrice,
      'products': productsMap,
      'dateTime': DateTime.now().toIso8601String(),
    };
  }

  OrderModel.fromDocument(DocumentSnapshot doc)
      : totalPrice = (doc['totalPrice'] ?? 0).toDouble(),
        products = (doc['products'] as List<dynamic>)
            .map((item) => Product.fromMap(item as Map<String, dynamic>))
            .toList(),
        orderDate = DateTime.parse(doc['dateTime'] ?? DateTime.now().toIso8601String());
}
