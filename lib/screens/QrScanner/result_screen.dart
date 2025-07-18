import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:paint_app/screens/bottom_nav_bar_screen.dart';

class ResultScreen extends StatelessWidget {
  final VoidCallback closeScreen;
  final String code;

  const ResultScreen({
    super.key,
    required this.closeScreen,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> decoded = jsonDecode(code);

    final String productId = decoded['productId'] ?? 'N/A';
    final String type = decoded['type'] ?? 'N/A';
    final String hash = decoded['hash'] ?? 'N/A';
    final int timestamp = decoded['timestamp'] ?? 0;

    // Optional reward (you can parse this from the API too if returned)
    final int coinsEarned = decoded['coinsEarned'] ?? 5000; // fallback

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
                    '🎉 Congratulations!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/coin.png',
                    height: 70,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$coinsEarned coins',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'have been added to your Wallet.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const Divider(height: 30, thickness: 1),
                  const Text(
                    'Product Scan Details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("🆔 Product ID: $productId"),
                        Text("📦 Type: $type"),
                        Text("🕒 Time: $timestamp"),
                        Text("🔑 Hash: $hash"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              // Close Button (top-right)
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
