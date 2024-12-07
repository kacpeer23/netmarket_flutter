import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:netmarket_flutter/models/address_info.dart';
import 'package:netmarket_flutter/models/order_model.dart';
import 'package:netmarket_flutter/services/database_service.dart';

import 'product.dart';

class Cart with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  final List<Product> _items = [];

  List<Product> get items => _items;

  void addItem(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.removeWhere((product) => product.id == productId);
    notifyListeners();
  }

  int get totalCountOfProducts {
    return _items.fold(0, (sum, product) => sum + product.countOfProducts);
  }

  double get totalPrice {
    double total = 0.0;
    for (var product in _items) {
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

  void clear() {
    _items.clear();
    notifyListeners();
  }

  Future<void> addOrder(
      {required String address,
      required String mobileNumber,
      required String name,
      required String email}) async {
    await _databaseService.addOrder(OrderModel(
      cartItems: _items,
      time: DateTime.now(),
      addressInfo: AddressInfo(
          address: address,
          date: DateFormat('MMM d, yyyy').format(DateTime.now()).toString(),
          mobileNumber: mobileNumber,
          name: name,
          pincode: '',
          time: DateTime.now()),
      email: email,
      status: 'confirmed',
    ));
    clear();
  }
}
