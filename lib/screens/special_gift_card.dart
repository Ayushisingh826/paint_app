import 'package:flutter/material.dart';
import 'package:paint_app/screens/reward_screen.dart';

class SpecialGiftCard extends StatelessWidget {
  const SpecialGiftCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RewardScreen()),
        );
      },
      child: Container(
        height: 170,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color.fromARGB(255, 184, 224, 243), Color(0xFFCCF2C3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            // Text content
            Flexible(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "We’ve Got a Special Gift Just for You",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "To thank you for being with us, here’s a surprise waiting to be unwrapped.",
                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(height: 14),
                  Text(
                    "Redeem Now →",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),

            // Gift Image
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/gift.png', // replace with actual image path
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
