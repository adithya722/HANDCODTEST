import 'package:flutter/material.dart';
import 'package:hancode/screens/cart_screen.dart';
import 'package:hancode/screens/home_screen.dart';
import 'package:hancode/screens/profile_screen.dart';
import 'package:hancode/screens/servicelisting_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  // Global key to access state from other widgets
  static final GlobalKey<_MainWrapperState> globalKey = GlobalKey<_MainWrapperState>();

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final screens = [
    const HomeScreen(),
    const ServiceListingScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  // Method to allow switching pages from child widgets
  void changePage(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.cleaning_services), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
