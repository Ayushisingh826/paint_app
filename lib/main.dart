import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:paint_app/screens/bottom_nav_bar_screen.dart';
import 'package:paint_app/screens/filter_screen.dart';
import 'package:paint_app/screens/home_screen.dart';
import 'package:paint_app/screens/Authentication/login_screen.dart';
import 'package:paint_app/screens/product_screen.dart';
import 'package:paint_app/screens/QrScanner/qr_scan_screen.dart';
import 'package:paint_app/screens/Authentication/signup_screen.dart';
import 'package:paint_app/screens/profile/profile_screen.dart';
import 'package:paint_app/screens/reward_screen.dart';
import 'package:paint_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:paint_app/screens/QrScanner/usedQr_screen.dart';
import 'package:paint_app/screens/Authentication/wraper.dart';
import 'package:paint_app/screens/withdraw.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override 
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),
    );
  }
}
