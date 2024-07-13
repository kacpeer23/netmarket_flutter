import 'package:flutter/material.dart';
import 'package:netmarket_flutter/screens/my_orders_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('My profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Shopping',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('My orders'),
                leading: const Icon(Icons.shopping_bag_outlined),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyOrdersScreen()));
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              )
            ],
          ),
        ));
  }
}
