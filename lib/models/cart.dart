import 'package:flutter/material.dart';

import 'product.dart';

class Cart with ChangeNotifier {
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
    return _items
        .fold(0, (sum, product) => sum + product.countOfProducts);
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
}
