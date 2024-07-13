import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String category;
  final String description;
  final String productImageUrl;
  final String price;
  final String title;
  final int id;
  int countOfProducts;

  Product({
    required this.category,
    required this.description,
    required this.productImageUrl,
    required this.price,
    required this.title,
    required this.id,
    required this.countOfProducts,
  });

  @override
  String toString() {
    return 'Product{category: $category, description: $description, productImageUrl: $productImageUrl, price: $price, title: $title, id: $id, countOfProducts: $countOfProducts}';
  }

  Product.fromMap(Map<String, dynamic> map)
      : category = map['category'] ?? '',
        description = map['description'] ?? '',
        productImageUrl = map['productImageUrl'] ?? '',
        price = map['price'],
        title = map['title'] ?? '',
        id = map['id'],
        countOfProducts = map['quantity'] ?? 0;

  Product.fromDocument(DocumentSnapshot json)
      : category = json['category'],
        description = json['description'],
        productImageUrl = json['productImageurl'],
        price = json['price'],
        title = json['title'],
        id = json['id'],
        countOfProducts = 0;

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'description': description,
      'productImageUrl': productImageUrl,
      'price': price,
      'title': title,
      'id': id,
      'quantity': countOfProducts,
    };
  }
  double get totalCost {
    double? priceDouble = double.tryParse(price);
    if (priceDouble != null) {
      return priceDouble * countOfProducts;
    } else {
      print('Error converting price for product $id: $price');
      return 0.0;
    }
  }
}
