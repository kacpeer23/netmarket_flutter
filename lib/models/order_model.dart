import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:netmarket_flutter/models/address_info.dart';
import 'package:netmarket_flutter/models/product.dart';

class OrderModel {
  final AddressInfo addressInfo;
  final List<Product> cartItems;
  final String email;
  final String status;
  final DateTime time;

  OrderModel({
    required this.addressInfo,
    required this.cartItems,
    required this.time,
    required this.email,
    required this.status,
  });

  @override
  toString() {
    return 'OrderModel{addressInfo: $addressInfo, cartItems: $cartItems, time: $time, email: $email, status: $status}';
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> productsMap =
        cartItems.map((item) => item.toMap()).toList();
    return {
      'email': email,
      'status': status,
      'cartItems': productsMap,
      'addressInfo': addressInfo.toMap(),
      'time': time.toIso8601String(),
      'date': DateFormat('MMM d, yyyy').format(time).toString(),
    };
  }

  List<OrderModel> sortOrdersByTime(List<OrderModel> orders) {
    orders.sort((a, b) => b.time.compareTo(a.time));
    return orders;
  }
  String get formattedDate {
    return DateFormat('d MMMM HH:mm', 'pl_PL').format(time).toString();
  }
  double get totalPrice {
    double total = 0.0;
    for (var product in cartItems) {
      double? price = double.tryParse(product.price);
      if (price != null) {
        total += price * product.countOfProducts;
      } else {
        print(
            'Error converting price for product ${product.id}: ${product.price}');
      }
    }
    return total;
  }

  OrderModel.fromDocument(DocumentSnapshot doc)
      : email = doc['email'].toString(),
        status = doc['status'].toString(),
        cartItems = (doc['cartItems'] as List<dynamic>)
            .map((item) => Product.fromMap(item as Map<String, dynamic>))
            .toList(),
        addressInfo = AddressInfo.fromMap(doc['addressInfo']),
        time = (doc['time'] as Timestamp).toDate();
}
