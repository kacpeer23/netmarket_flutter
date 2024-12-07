import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final fireBaseAuth = FirebaseAuth.instance;
    try {
      Map<String, dynamic> orderData = order.toMap();
      String uid = fireBaseAuth.currentUser!.uid;
      print('Order data to be added to Firestore: $orderData');
      await _firestore.collection('order').doc(uid).set(orderData);
    } catch (e) {
      print('Error adding order to Firestore: $e');
    }
  }

  Future<List<OrderModel>> getOrders() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('order').get();
      List<OrderModel> orders = querySnapshot.docs
          .map((doc) {
            print('doc: ${doc.data()}');
            return OrderModel.fromDocument(doc);})
          .toList();
      log('Orders retrieved from Firestore: $orders');
      return orders;
    } catch (e, st) {
      print('Error retrieving orders: $e, $st');
      return [];
    }
  }

}
