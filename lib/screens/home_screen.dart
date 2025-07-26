import 'package:flutter/material.dart';
import 'package:paint_app/screens/category.dart';
import 'package:paint_app/screens/colors.dart';
import 'package:paint_app/screens/gradient_background.dart';
import 'package:paint_app/screens/bottom_nav_bar_screen.dart';
import 'package:paint_app/screens/onboarding_carousel.dart';
import 'package:paint_app/screens/contact_details.dart';
import 'package:paint_app/screens/reward_card.dart';
import 'package:paint_app/screens/special_gift_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),

                  // Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: AppColors.textfield,
                            filled: true,
                            hintText: "Search",
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContactUsScreen()));
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.textfield,
                          child:
                              const Icon(Icons.headphones, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const RewardCard(),

                  const SizedBox(height: 30),

                  // Categories
                  SizedBox(
                    height: 90,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        CategoryItem(
                            name: "Interior",
                            imagePath: "assets/images/interior.png"),
                        CategoryItem(
                            name: "Exterior",
                            imagePath: "assets/images/exterior.png"),
                        CategoryItem(
                            name: "Exterior",
                            imagePath: "assets/images/waterproof.png"),
                        CategoryItem(
                            name: "Exterior",
                            imagePath: "assets/images/woodfinisher.png"),
                        CategoryItem(
                            name: "Exterior",
                            imagePath: "assets/images/exterior.jpg"),
                        CategoryItem(
                            name: "Exterior",
                            imagePath: "assets/images/exterior2.png"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 👉 Onboarding carousel
                  const OnboardingCarousel(),
                  const SizedBox(height: 20),
                  const SpecialGiftCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
