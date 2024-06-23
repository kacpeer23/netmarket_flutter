import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netmarket_flutter/models/product.dart';

class DatabaseService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Product> _items = [];

  List<Product> get items => _items;

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

  Future<void> addItem(String name) async {
    try {
      await _firestore.collection('items').add({'name': name});
      fetchItems();
    } catch (e) {
      print(e);
    }
  }
}
