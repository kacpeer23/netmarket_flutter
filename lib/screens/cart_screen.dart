import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netmarket_flutter/models/cart.dart';
import 'package:netmarket_flutter/services/auth_service.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final authService = Provider.of<AuthService>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Twój koszyk'),
      ),
      body: ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: isDarkMode ? Colors.grey[850] : Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.25)
                                  : Colors.black.withOpacity(0.25),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: const Offset(4, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: CachedNetworkImageProvider(
                              cart.items[index].productImageUrl),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cart.items[index].title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${cart.items[index].totalCost.toStringAsFixed(2)} zł',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    '${cart.items[index].countOfProducts}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  cart.removeItem(cart.items[index].id);
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Text('Łącznie: ${cart.totalPrice.toStringAsFixed(2)} zł',
                  style: const TextStyle(fontSize: 20)),
            ),
            ElevatedButton(
              onPressed: () {
                _showOrderDialog(context, cart, authService);
              },
              child: const Text('Zamów'),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDialog(
      BuildContext context, Cart cart, AuthService authService) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Szczegóły zamówienia'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Imię i nazwisko',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wproawdź swoje imię i nazwisko';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Adres',
                    prefixIcon: Icon(Icons.home),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wprowadź adres dotawy';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _mobileNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Numer telefonu',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Wprowadź swój numer telefonu';
                    }
                    if (value.length < 9) {
                      return 'Wprowadź poprawny numer';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Anuluj'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final name = _nameController.text;
                  final address = _addressController.text;
                  final mobileNumber = _mobileNumberController.text;

                  // Add order logic
                  cart.addOrder(
                      name: name,
                      address: address,
                      mobileNumber: mobileNumber,
                      email: authService.currentUser?.email ?? '');

                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Zamówienie zlożone pomyślnie!'),
                      backgroundColor: Colors.green,
                    ),
                  );

                  // Clear form fields
                  _nameController.clear();
                  _addressController.clear();
                  _mobileNumberController.clear();
                }
              },
              child: const Text('Potwierdź'),
            ),
          ],
        );
      },
    );
  }
}
