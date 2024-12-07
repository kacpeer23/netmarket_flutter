import 'package:flutter/material.dart';
import 'package:netmarket_flutter/screens/my_orders_screen.dart';
import 'package:netmarket_flutter/screens/user_data_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Mój profil'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListTile(
                title: const Text('Ustawienia konta'),
                leading: const Icon(Icons.person_outline),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserDataScreen()));
                },
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('Moje zamówienia'),
                leading: const Icon(Icons.shopping_bag_outlined),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyOrdersScreen()));
                },
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: isDarkMode ? Colors.white : Colors.black,
                      width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
        ));
  }
}
