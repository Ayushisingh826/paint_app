import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileButton extends StatefulWidget {
  final Map<String, String> personalDetails;
  final void Function(Map<String, dynamic>)? onProfileUpdated;

  const UpdateProfileButton({
    Key? key,
    required this.personalDetails,
    this.onProfileUpdated,
  }) : super(key: key);

  @override
  State<UpdateProfileButton> createState() => _UpdateProfileButtonState();
}

class _UpdateProfileButtonState extends State<UpdateProfileButton> {
  bool isLoading = false;
  String jwtToken = '';

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      jwtToken = prefs.getString('authToken') ?? '';
    });
  }

  Future<void> _updateProfile() async {
    setState(() => isLoading = true);

    try {
      final fullName = widget.personalDetails['fullName'];
      final profileImage = widget.personalDetails['profileImage'];

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('https://kkd-backend-api.onrender.com/api/user/update-profile'),
      );

      request.headers['Authorization'] = 'Bearer $jwtToken';
      if (fullName != null) request.fields['fullName'] = fullName;
      if (profileImage != null && profileImage.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath('profilePick', profileImage),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final result = jsonDecode(response.body);

      if (result['success'] == true && widget.onProfileUpdated != null) {
        widget.onProfileUpdated!(result['data']); // callback with updated data
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Profile updated')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Network error occurred')),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : _updateProfile,
        icon: const Icon(Icons.save),
        label: isLoading
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
            : const Text("Update Profile", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
