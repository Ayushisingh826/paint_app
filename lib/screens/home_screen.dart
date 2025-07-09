import 'package:flutter/material.dart';
import 'package:paint_app/screens/category.dart';
import 'package:paint_app/screens/colors.dart';
import 'package:paint_app/screens/gradient_background.dart';
import 'package:paint_app/screens/bottom_nav_bar_screen.dart';

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
                      CircleAvatar(
                        backgroundColor: AppColors.textfield,
                        child: const Icon(Icons.headphones, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                                      
                  // User Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.pink.shade100, Colors.purple.shade100],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("TOTAL COINS",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("XXXX XXXX XXXX XXXX\nAAYUSH GUPTA",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Row(
                              children: [
                                const Text("5000",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(width: 5),
                                Image.asset('assets/images/coin.png', height: 24),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Text("View Details",
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                                      
                  const SizedBox(height: 20),
                                      
                  // Categories
                  SizedBox(
                    height: 90,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        CategoryItem(
                            name: "Interior",
                            imagePath: "assets/images/interior.jpg"),
                        CategoryItem(
                            name: "Exterior",
                            imagePath: "assets/images/exterior.jpg"),
                            CategoryItem(
                            name: "Exterior",
                            imagePath: "assets/images/exterior.jpg"),
                            CategoryItem(
                            name: "Exterior",
                            imagePath: "assets/images/exterior.jpg"),
                            CategoryItem(
                            name: "Exterior",
                            imagePath: "assets/images/exterior.jpg"),
                            CategoryItem(
                            name: "Exterior",
                            imagePath: "assets/images/exterior.jpg"),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('Top Product',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}