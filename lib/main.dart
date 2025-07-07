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
import 'package:paint_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:paint_app/screens/QrScanner/usedQr_screen.dart';
import 'package:paint_app/screens/Authentication/wraper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBTh2EupMYmr3c6Qzyp-DyZuLNWnapsBe4",
            authDomain: "paintapp-9f031.firebaseapp.com",
            projectId: "paintapp-9f031",
            storageBucket: "paintapp-9f031.firebasestorage.app",
            messagingSenderId: "227504674876",
            appId: "1:227504674876:web:9562b9ab10acf079504b39"));
  } else {
     await Firebase.initializeApp();
     
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:ProfileScreen(),
    );
  }
}
