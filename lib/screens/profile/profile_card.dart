import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paint_app/screens/profile/update_profile.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String fullName = 'Loading...';
  String role = 'Loading...';
  String? profileUrl;
  File? selectedImage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
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
        final data = jsonDecode(response.body)['data'];
        setState(() {
          fullName = data['fullName'] ?? 'User';
          role = data['bankName'] ?? 'N/A';
          profileUrl = data['profilePick'];
          isLoading = false;
        });
      } else {
        print("Error fetching profile: ${response.body}");
      }
    } catch (e) {
      print("Exception fetching profile: $e");
    }
  }

  Future<void> pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken') ?? '';

    final uri = Uri.parse(
        'https://kkd-backend-api.onrender.com/api/user/update-profile-pic');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('profilePic', file.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Profile image updated');
        setState(() {
          selectedImage = File(file.path);
        });
        // Refetch profile to update URL and fullName
        await fetchUserProfile();
      } else {
        print('Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during image upload: $e');
    }
  }

  Widget _buildProfileImage() {
    if (selectedImage != null) {
      return CircleAvatar(
        radius: 40,
        backgroundImage: FileImage(selectedImage!),
      );
    } else if (profileUrl != null && profileUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: 40,
        backgroundImage: CachedNetworkImageProvider(profileUrl!),
      );
    } else {
      // Display initials if profilePic is null
      final initials = fullName.isNotEmpty
          ? fullName.trim().split(' ').map((e) => e[0]).take(2).join()
          : '?';
      return CircleAvatar(
        radius: 40,
        backgroundColor: Colors.deepPurple,
        child: Text(
          initials.toUpperCase(),
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: pickProfileImage,
            child: _buildProfileImage(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  role,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          UpdateProfileButton(
            personalDetails: {
              'name': fullName,
              'role': role,
            },
          ),
        ],
      ),
    );
  }
}
