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

  Product.fromDocument(DocumentSnapshot json)
      : category = json['category'],
        description = json['description'],
        productImageUrl = json['productImageurl'],
        price = json['price'],
        title = json['title'],
        id = json['id'],
        countOfProducts = 0;

  double get totalCost {
    double? priceDouble = double.tryParse(price);
    if (priceDouble != null) {
      return priceDouble * countOfProducts;
    } else {
      print('Error converting price for product $id: $price');
      return 0.0;
    }
  }

  Map<String, dynamic> toMap() => {
        'category': category,
        'description': description,
        'productImageUrl': productImageUrl,
        'price': price,
        'title': title,
        'id': id,
      };
}
