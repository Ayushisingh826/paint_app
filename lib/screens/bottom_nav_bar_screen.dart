import 'package:flutter/material.dart';
import 'package:paint_app/screens/colors.dart';
import 'package:paint_app/screens/home_screen.dart';
import 'package:paint_app/screens/product_screen.dart';
import 'package:paint_app/screens/profile/profile_screen.dart';
import 'package:paint_app/screens/QrScanner/qr_scan_screen.dart';
import 'package:paint_app/screens/reward_detail_screen.dart';
import 'package:paint_app/screens/reward_screen.dart';
import 'package:paint_app/screens/wallet_screen.dart';
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
    WalletScreen(),
    RewardScreen(),
    RewardDetailsScreen(),
    
  ];

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.background2,
      body: _screens[selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(fixedColor:null,
     currentIndex: selectedIndex,
        onTap: onTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits_sharp), label: "Product"),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_outlined), label: "QR Scan"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_outlined), label: "Withdraw"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
