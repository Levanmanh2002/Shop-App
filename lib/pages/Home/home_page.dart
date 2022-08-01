import 'package:flutter/material.dart';
import 'package:shop/pages/Home/main_food_page.dart';
import 'package:shop/pages/accout/account.dart';
import 'package:shop/pages/cart/cart_history.dart';
import 'package:shop/pages/order/order_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List pages = [
    const MainFoodPage(),
    const OrderPage(),
    const CartHistory(),
    const AccOuntPage(),
  ];

  void onTapNavigationBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF89dad0),
        unselectedItemColor: Colors.pink,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _selectedIndex,
        onTap: onTapNavigationBar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Messages",
          ),
        ],
      ),
    );
  }
}
