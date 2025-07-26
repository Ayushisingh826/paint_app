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
final TextEditingController fullNameController = TextEditingController();
final TextEditingController  dobController = TextEditingController();
final TextEditingController  addressController = TextEditingController();
final TextEditingController pinCodeController = TextEditingController();
final TextEditingController stateController = TextEditingController();
final TextEditingController countryController = TextEditingController();
final TextEditingController accountNumberController = TextEditingController();
final TextEditingController accountHolderController = TextEditingController();
final TextEditingController bankNameController = TextEditingController();
final TextEditingController ifscCodeController = TextEditingController();

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
          fullName = data['fullName'] ?? data['accountHolderName'];
          fullNameController.text = fullName;
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
      TextFormField(
        controller: fullNameController..text = fullName,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Full Name',
          isDense: true,
        ),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
     "fullName": fullNameController.text,
    "Date of Birth": dobController.text,
    "Permanent Address": addressController.text,
    "Pin Code": pinCodeController.text,
    "State": stateController.text,
    "Country": countryController.text,
    "Account Number": accountNumberController.text,
    "Account Holder Name": accountHolderController.text,
    "Bank Name": bankNameController.text,
    "IFSC Code": ifscCodeController.text,
  },
  onProfileUpdated: (updatedProfile) {
    setState(() {
      fullName = updatedProfile['fullName'] ?? fullName;
      fullNameController.text = fullName;
      role = updatedProfile['bankName'] ?? role;
      profileUrl = updatedProfile['profilePick'] ?? profileUrl;
      // Update other controllers if needed
      dobController.text = updatedProfile['Date of Birth'] ?? dobController.text;
      addressController.text = updatedProfile['Permanent Address'] ?? addressController.text;
      pinCodeController.text = updatedProfile['Pin Code'] ?? pinCodeController.text;
      stateController.text = updatedProfile['State'] ?? stateController.text;
      countryController.text = updatedProfile['Country'] ?? countryController.text;
      accountNumberController.text = updatedProfile['Account Number'] ?? accountNumberController.text;
      accountHolderController.text = updatedProfile['Account Holder Name'] ?? accountHolderController.text;
      bankNameController.text = updatedProfile['Bank Name'] ?? bankNameController.text;
      ifscCodeController.text = updatedProfile['IFSC Code'] ?? ifscCodeController.text;
    });
  },
)

        ],
      ),
    );
  }
}
