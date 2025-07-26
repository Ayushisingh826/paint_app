import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paint_app/screens/Authentication/login_screen.dart';
import 'package:paint_app/screens/gradient_background.dart';
import 'package:paint_app/screens/profile/bank_details_card.dart';
import 'package:paint_app/screens/profile/kyc_screen.dart';
import 'package:paint_app/screens/profile/profile_card.dart';
import 'package:paint_app/screens/profile/profile_completion_card.dart';
import 'package:paint_app/screens/profile/update_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int getCompletedSections() {
    int completedSections = 0;

    if (_isPersonalDetailsComplete()) completedSections++;
    if (_isKycComplete()) completedSections++;
    if (_isBankDetailsComplete()) completedSections++;

    return completedSections;
  }

  bool _isPersonalDetailsComplete() {
    // At least 6 of 7 fields filled
    int filled =
        _personalDetails.values.where((v) => v.trim().isNotEmpty).length;
    return filled >= 6;
  }

  bool _isKycComplete() {
    
    return true; 
  }

  bool _isBankDetailsComplete() {
  
    return true; 
  }

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
    if (jwtToken.isEmpty) return;

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
          _personalDetails["Permanent Address"] =
              user['address']?.toString() ?? '';
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
    String? result =
        await showEditDialog(context, key, _personalDetails[key] ?? '');
    if (result != null && result.isNotEmpty) {
      setState(() {
        _personalDetails[key] = result;
      });
    }
  }

  Widget buildInfoRow(String label, String value, VoidCallback onEdit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
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
                top: 16,
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

                      ProfileCompletionCard(
                          completedSections: getCompletedSections()),
                      const SizedBox(height: 16),
                      // 🔽 Personal details box
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF3FF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.lightBlue),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Personal Details",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const Divider(thickness: 1, color: Colors.black),
                            ..._personalDetails.entries.map(
                              (entry) => buildInfoRow(
                                entry.key,
                                entry.value,
                                () => _editDetail(entry.key),
                              ),
                            ),
                          ],
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
