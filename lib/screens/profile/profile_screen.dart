import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paint_app/screens/Authentication/login_screen.dart';
import 'package:paint_app/screens/gradient_background.dart';
import 'package:paint_app/screens/profile/bank_details_card.dart';
import 'package:paint_app/screens/profile/kyc_screen.dart';
import 'package:paint_app/screens/profile/profile_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, String> _personalDetails = {
    "Contact Number": "",
    "Email Id": "",
    "Date of Birth": "",
    "Permanent Address": "",
    "Pin Code": "",
    "State": "",
    "Country": "",
  };

  String jwtToken = '';

  @override
  void initState() {
    super.initState();
    loadTokenAndFetchProfile();
  }

  Future<void> loadTokenAndFetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    jwtToken = prefs.getString('authToken') ?? '';
    if (jwtToken.isNotEmpty) {
      await fetchUserProfile();
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Future<void> fetchUserProfile() async {
    if (jwtToken.isEmpty) {
      print("JWT token not found!");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("https://kkd-backend-api.onrender.com/api/user/get-user"),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = data['data'];

        setState(() {
          _personalDetails["Contact Number"] = user['phone']?.toString() ?? '';
    _personalDetails["Email Id"] = user['email']?.toString() ?? '';
    _personalDetails["Date of Birth"] = user['dob']?.toString() ?? '';
    _personalDetails["Permanent Address"] = user['address']?.toString() ?? '';
    _personalDetails["Pin Code"] = user['pinCode']?.toString() ?? '';
    _personalDetails["State"] = user['state']?.toString() ?? '';
    _personalDetails["Country"] = user['country']?.toString() ?? '';
        });
      } else {
        print("Failed to fetch profile: ${response.body}");
      }
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }

  void _editDetail(String key) async {
    String? result = await showEditDialog(context, key, _personalDetails[key] ?? '');
    if (result != null && result.isNotEmpty) {
      setState(() {
        _personalDetails[key] = result;
      });
    }
  }

  Widget buildInfoRow(String label, String value, VoidCallback onEdit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Text(value),
              IconButton(
                  icon: const Icon(Icons.edit, size: 16), onPressed: onEdit),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                right: 16,
                top: 8,
                child: IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  tooltip: 'Logout',
                  onPressed: _logout,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProfileCard(),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF3FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Complete your profile",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("This helps build trust, encouraging members"),
                            SizedBox(height: 4),
                            LinearProgressIndicator(value: 0.66),
                            SizedBox(height: 4),
                            Text("2 out of 3 complete",
                                style: TextStyle(color: Colors.teal)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text("Personal details",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const Divider(thickness: 1, color: Colors.black),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF3FF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.lightBlue),
                        ),
                        child: Column(
                          children: _personalDetails.entries.map((entry) {
                            return buildInfoRow(entry.key, entry.value,
                                () => _editDetail(entry.key));
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const KycCard(),
                      const SizedBox(height: 16),
                      const BankDetailsCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String?> showEditDialog(
    BuildContext context, String field, String currentValue) {
  TextEditingController controller = TextEditingController(text: currentValue);

  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Edit $field'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: field),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, controller.text),
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
