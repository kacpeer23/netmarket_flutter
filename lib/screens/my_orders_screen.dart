import 'package:flutter/material.dart';
import 'package:netmarket_flutter/models/product.dart';
import 'package:netmarket_flutter/services/database_service.dart';
import 'package:provider/provider.dart';

class MyOrdersScreen extends StatelessWidget {

  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final databaseService = Provider.of<DatabaseService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: FutureBuilder(
        future: databaseService.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found.'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderContainer(
                  orderDate: order.orderDate.toString(),
                  totalPrice: order.totalPrice,
                  products: order.products,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class OrderContainer extends StatelessWidget {
  final String orderDate;
  final double totalPrice;
  final List<Product> products;

  const OrderContainer({super.key,
    required this.orderDate,
    required this.totalPrice,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
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
            ...products.map((product) => ProductTile(product: product)),
          ],
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

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