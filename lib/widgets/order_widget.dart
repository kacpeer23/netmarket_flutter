import 'package:flutter/material.dart';
import 'package:netmarket_flutter/models/product.dart';

class OrderWidget extends StatelessWidget {
  final String orderDate;
  final double totalPrice;
  final List<Product> products;

  OrderWidget({
    required this.orderDate,
    required this.totalPrice,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Date: $orderDate',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Divider(),
            ...products
                .map((product) => ProductTile(product: product))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product product;

  ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(product.productImageUrl, width: 50, height: 50),
      title: Text(product.title),
      subtitle: Text('Price: \$${product.price}'),
      trailing: Text('Quantity: ${product.countOfProducts}'),
    );
  }
}
