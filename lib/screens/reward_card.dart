import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RewardCard extends StatefulWidget {
  const RewardCard({Key? key}) : super(key: key);

  @override
  State<RewardCard> createState() => _RewardCardState();
}

class _RewardCardState extends State<RewardCard> {
  String fullName = "Loading...";
  String accountNumber = "XXXX XXXX XXXX XXXX";
  int coinBalance = 0;

  @override
  void initState() {
    super.initState();
    fetchRewardDetails();
  }

  Future<void> fetchRewardDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken') ?? '';

    if (token.isEmpty) return;

    try {
      final response = await http.get(
        Uri.parse('https://kkd-backend-api.onrender.com/api/user/get-user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = data['data'];

        setState(() {
          fullName = user['fullName']?? user['accountHolderName'] ;
          coinBalance = user['coinsEarned'] ?? 0;

          // Option 1: If accountNumber exists from API
          accountNumber =
              user['accountNumber'] ?? generateMaskedNumber(user['_id'] ?? '');

          // Option 2 fallback: Generate masked number from user ID
        });
      } else {
        print("Error fetching user: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  String generateMaskedNumber(String userId) {
    if (userId.length < 8) return "XXXX XXXX XXXX XXXX";
    final tail = userId.substring(userId.length - 4);
    return "XXXX XXXX XXXX $tail";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "TOTAL COINS",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "KKD Card",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Image.asset('assets/images/coin.png', height: 24),
              const SizedBox(width: 5),
              Text(
                "$coinBalance",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            accountNumber,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            fullName.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "View Details",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}