import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String category;
  final String description;
  final String productImageUrl;
  final String price;
  final String title;

  Product(
      {required this.category,
      required this.description,
      required this.productImageUrl,
      required this.price,
      required this.title});

  Product.fromDocument(DocumentSnapshot json)
      : category = json['category'],
        description = json['description'],
        productImageUrl = json['productImageurl'],
        price = json['price'],
        title = json['title'];

  Map<String, dynamic> toMap() => {
        'category': category,
        'description': description,
        'productImageUrl': productImageUrl,
        'price': price,
        'title': title,
      };
}
