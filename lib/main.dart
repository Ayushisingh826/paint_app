import 'package:flutter/material.dart';
import 'package:paint_app/screens/bottom_nav_bar_screen.dart';
import 'package:paint_app/screens/filter_screen.dart';
import 'package:paint_app/screens/home_screen.dart';
import 'package:paint_app/screens/login_screen.dart';
import 'package:paint_app/screens/product_screen.dart';
import 'package:paint_app/screens/signup_screen.dart';
import 'package:paint_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductScreen(),
    );
  }
}
