import 'package:flutter/material.dart';
import 'package:paint_app/screens/colors.dart';

class RewardDetailsScreen extends StatelessWidget {
  const RewardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48), // 👈 48px top space
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Product Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Product Image
            Center(
              child: Image.asset(
                'assets/images/rewards.png',
                height: 208,
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              'Hyundai Creta',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Hyundai Creta (E 1.5 petrol Version)',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text(
              'Hyundai Creta (E 1.5 petrol) is available in Manual transmission.',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 4),
            const Text.rich(
              TextSpan(
                text: 'Purchasing Points: ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
                children: [
                  TextSpan(
                    text: '2,50,000',
                    style: TextStyle(color: Color(0xFF678D0D)),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.ButtonBackground,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                onPressed: () {
                  // 🔄 Implement redeem logic
                },
                child: const Text('Redeem',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
