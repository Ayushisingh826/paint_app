import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:paint_app/screens/bottom_nav_bar_screen.dart';
import 'package:paint_app/screens/gradient_background.dart';
import 'package:paint_app/screens/product_screen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final List<String> categories = [
    'Interior',
    'Exterior',
    'Waterproofing',
    'Woodfinish'
  ];
  final List<String> prices = [
    '1000',
    '3000',
    '5000',
    '8000',
    '12,000',
    '15,000',
    '20,000'
  ];

  String? selectedCategory;
  String? selectedPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search),
                            hintText: "Search",
                            border: InputBorder.none,
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
                              builder: (context) => const BottomNavBarScreen()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.tune),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Product cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildProductCard(),
                    _buildProductCard(),
                  ],
                ),

                const SizedBox(height: 24),
                const Divider(),

                const Text("Filter",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),

                // Category Filter
                _buildSectionTitle("Category"),
                Wrap(
                  spacing: 8,
                  children: categories
                      .map((cat) => ChoiceChip(
                            label: Text(cat),
                            selected: selectedCategory == cat,
                            onSelected: (_) =>
                                setState(() => selectedCategory = cat),
                            selectedColor: Colors.black,
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                              color: selectedCategory == cat
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ))
                      .toList(),
                ),

                const SizedBox(height: 20),

                // Price Filter
                _buildSectionTitle("Price"),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: prices
                      .map((price) => ChoiceChip(
                            label: Text(price),
                            selected: selectedPrice == price,
                            onSelected: (_) =>
                                setState(() => selectedPrice = price),
                            selectedColor: Colors.black,
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                              color: selectedPrice == price
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ))
                      .toList(),
                ),

                const SizedBox(height: 24),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedCategory = null;
                            selectedPrice = null;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black),
                        ),
                        child: const Text("Clean"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Apply filter logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: const Text("Apply Changes",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      );

  Widget _buildProductCard() {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Image.asset('assets/images/paint.png',
                  height: 100, fit: BoxFit.cover), // Replace with your image
              Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.monetization_on, size: 14, color: Colors.white),
                    SizedBox(width: 2),
                    Text('500',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Birla Opus Style Perfect Start Primer',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Text('944353', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
