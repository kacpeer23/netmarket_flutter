import 'package:flutter/material.dart';
import 'package:netmarket_flutter/models/cart.dart';
import 'package:netmarket_flutter/pages/main_page.dart';
import 'package:netmarket_flutter/screens/cart_screen.dart';
import 'package:netmarket_flutter/screens/profile_screen.dart';
import 'package:netmarket_flutter/screens/search_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      print('Current index: $currentIndex');
    });
  }

  final List<Widget> _children = [
    const MainPage(),
    SearchScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            color: Colors.grey,
            thickness: 1,
            height: 1,
          ),
          BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTabTapped,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: ''),
              const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Badge(
                    isLabelVisible: cart.totalCountOfProducts > 0,
                    label: Text(cart.totalCountOfProducts.toString()),
                    offset: const Offset(10, -12),
                    child: const Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                  label: ''),
              const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: ''),
            ],
          ),
        ],
      ),
      body: _children[currentIndex],
    );
  }
}
