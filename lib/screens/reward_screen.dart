import 'package:flutter/material.dart';
import 'package:paint_app/screens/gradient_background.dart';
import 'package:paint_app/screens/reward_detail_screen.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // 🔙 Top AppBar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Offers',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Icon(Icons.more_vert),
                  ],
                ),
              ),

              // 🚗 Offers Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(
                      itemCount: 6,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.80,
                      ),
                      itemBuilder: (context, index) {
                        return OfferCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RewardDetailsScreen()),
                            );
                          },
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  final VoidCallback onTap;
  const OfferCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/rewards.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 6),
            const Text('Hyundai Creta',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text(
              'Hyundai Creta (E 1.5 petrol Version)',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
