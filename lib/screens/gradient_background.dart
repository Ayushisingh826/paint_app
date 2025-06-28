import 'package:flutter/material.dart';
import 'package:paint_app/screens/colors.dart'; // your color file

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
         gradient: LinearGradient(
              colors: [AppColors.background1, AppColors.background2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
      ),
      child: child,
    );
  }
}
