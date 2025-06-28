import 'package:flutter/material.dart';
import 'package:paint_app/screens/home_screen.dart';
import 'package:paint_app/screens/product_screen.dart';
import 'package:paint_app/screens/profile_screen.dart';
import 'package:paint_app/screens/qr_scan_screen.dart';
import 'package:paint_app/screens/withdraw.dart';



class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ProductScreen(),
    QrScanScreen(),
    WithdrawScreen(),
    ProfileScreen(),
  ];

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[selectedIndex], // <-- show selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits), label: "Product"),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner), label: "QR Scan"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Withdraw"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
