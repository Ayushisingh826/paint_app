import 'package:flutter/material.dart';
import 'package:paint_app/screens/Authentication/signup_screen.dart';
import 'package:paint_app/screens/gradient_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _revealAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _revealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SignupScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: AnimatedBuilder(
            animation: _revealAnimation,
            builder: (context, child) {
              return ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: _revealAnimation.value,
                  child: child,
                ),
              );
            },
            child: Image.asset(
              "assets/images/logo.png",
              height: 180,
              width: 180,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
