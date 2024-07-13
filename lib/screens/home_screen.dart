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
    CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          const BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: ''),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: cart.totalCountOfProducts > 0,
                label: Text(cart.totalCountOfProducts.toString()),
                offset: const Offset(10, -12),
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
              ),
              label: ''),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: ''),
        ],
      ),
      body: _children[currentIndex],
    );
  }
}
