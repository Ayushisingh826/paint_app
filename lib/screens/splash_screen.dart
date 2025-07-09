import 'package:flutter/material.dart';
import 'package:paint_app/screens/bottom_nav_bar_screen.dart';
import 'package:paint_app/screens/colors.dart';
import 'package:paint_app/screens/gradient_background.dart';
import 'package:paint_app/screens/Authentication/signup_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SignupScreen()),
      );
    });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
         child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png",height: 180,width: 180,fit: BoxFit.fill,),
          ],
        ),
       ),
        ),
    );
  }
}
