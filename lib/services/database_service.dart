import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netmarket_flutter/models/order_model.dart';
import 'package:netmarket_flutter/models/product.dart';

class DatabaseService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> fetchItems() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('product').get();
      final products =
          snapshot.docs.map((doc) => Product.fromDocument(doc)).toList();
      notifyListeners();
      return products;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Product>> fetchItemsByCategory(String category) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('product')
          .where('category', isEqualTo: category)
          .get();
      final products =
          snapshot.docs.map((doc) => Product.fromDocument(doc)).toList();
      notifyListeners();
      return products;
    } catch (e) {
      return [];
    }
  }

  Future<void> addItem(String name) async {
    try {
      await _firestore.collection('items').add({'name': name});
      fetchItems();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addOrder(OrderModel order) async {
    int newOrderId = await _getNewOrderId();

    if (newOrderId == -1) {
      print('Error retrieving new order ID');
      return;
    }

    try {
      Map<String, dynamic> orderData = order.toMap(newOrderId);
      print('Order data to be added to Firestore: $orderData');
      await _firestore
          .collection('orders')
          .doc(newOrderId.toString())
          .set(orderData);
      print('Order added to Firestore with ID: $newOrderId');
    } catch (e) {
      print('Error adding order to Firestore: $e');
    }
  }


  Future<List<OrderModel>> getOrders() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('orders').get();
      List<OrderModel> orders = querySnapshot.docs
          .map((doc) => OrderModel.fromDocument(doc))
          .toList();
      log('Orders retrieved from Firestore: $orders');
      return orders;
    } catch (e) {
      print('Error retrieving orders: $e');
      return [];
    }
  }
  Future<int> _getNewOrderId() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('orders')
          .orderBy('id', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var lastOrder = querySnapshot.docs.first;
        int lastOrderId = lastOrder['id'];
        return lastOrderId + 1;
      } else {
        return 1;
      }
    } catch (e) {
      print('Error retrieving last order ID: $e');
      return -1;
    }
  }
}
