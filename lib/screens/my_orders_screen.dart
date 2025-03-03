import 'package:cached_network_image/cached_network_image.dart';
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
        title: const Text('Zamówienia'),
      ),
      body: FutureBuilder(
        future: databaseService.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Błąd: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nie znaleziono zamówień'));
          } else {
            final orders = snapshot.data!;
            orders.sort((a, b) => b.time.compareTo(a.time));
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderContainer(
                  orderDate: order.formattedDate,
                  totalPrice: order.totalPrice.toDouble(),
                  products: order.cartItems,
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

  const OrderContainer({
    super.key,
    required this.orderDate,
    required this.totalPrice,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data zamówienia: $orderDate',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Łączna cena: \$${totalPrice.toStringAsFixed(2)}',
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: product.productImageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.25)
                    : Colors.black.withOpacity(0.25),
                offset: const Offset(4, 4),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(product.title),
      subtitle: Text('Cena: \$${product.price}'),
      trailing: Text('Ilość: ${product.countOfProducts}'),
    );
  }
}
