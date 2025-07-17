// reward_details_screen.dart

import 'package:flutter/material.dart';

class RewardDetailsScreen extends StatelessWidget {
  const RewardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Product Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/rewards.png',
                height: 180,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Hyundai Creta',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Hyundai Creta (E 1.5 petrol Version)',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 8),
            const Text(
              'Hyundai Creta (E 1.5 petrol) is available in Manual transmission.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text.rich(
              TextSpan(
                text: 'Purchasing Points: ',
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: '2,50,000',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  // 🔄 Implement redeem logic
                },
                child: const Text('Redeem', style: TextStyle(fontSize: 16,color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
