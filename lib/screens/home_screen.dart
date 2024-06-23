import 'package:flutter/material.dart';
import 'package:netmarket_flutter/pages/main_page.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              label: ''),
          BottomNavigationBarItem(
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
