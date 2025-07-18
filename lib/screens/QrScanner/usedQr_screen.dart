import 'package:flutter/material.dart';
import 'package:paint_app/screens/bottom_nav_bar_screen.dart';

class UsedQrScreen extends StatelessWidget {
  final String name;
  final String date;
  final Function() closeScreen;

  const UsedQrScreen({
    super.key,
    required this.name,
    required this.date,
    required this.closeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Oops!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Icon(Icons.close_outlined,
                      size: 80, color: Colors.redAccent),
                  const SizedBox(height: 20),
                  Text(
                    "This QR code has already been used by $name on $date.",
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>BottomNavBarScreen() ));
                  },
                  child: const Icon(Icons.close, size: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
