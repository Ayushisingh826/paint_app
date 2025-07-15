import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paint_app/screens/colors.dart';
import 'package:paint_app/screens/gradient_background.dart';

class UploadPassbookScreen extends StatefulWidget {
  const UploadPassbookScreen({Key? key}) : super(key: key);

  @override
  State<UploadPassbookScreen> createState() => _UploadPassbookScreenState();
}

class _UploadPassbookScreenState extends State<UploadPassbookScreen> {
  File? _selectedFile;
  XFile? _webFile;
  bool isUploading = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (kIsWeb) {
          _webFile = pickedFile;
        } else {
          _selectedFile = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _uploadPassbook() async {
    setState(() {
      isUploading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) throw Exception("No token found");

      var uri = Uri.parse('https://kkd-backend-api.onrender.com/api/user/upload-passbook');
      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token';

      http.MultipartFile multipartFile;

      if (kIsWeb && _webFile != null) {
        final bytes = await _webFile!.readAsBytes();
        multipartFile = http.MultipartFile.fromBytes(
          'passbookPhoto',
          bytes,
          filename: _webFile!.name,
          contentType: MediaType('image', 'jpeg'),
        );
      } else if (_selectedFile != null) {
        multipartFile = await http.MultipartFile.fromPath(
          'passbookPhoto',
          _selectedFile!.path,
          contentType: MediaType('image', 'jpeg'),
        );
      } else {
        throw Exception("No image selected");
      }

      request.files.add(multipartFile);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("📦 Raw response body: \${response.body}");
      print("📦 Status code: \${response.statusCode}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Passbook uploaded successfully")),
        );
        Navigator.pop(context);
      } else {
        throw Exception(data['message'] ?? "Upload failed");
      }
    } catch (e) {
      print("❌ Upload Error: \$e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: \$e")),
      );
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background1,
      appBar: AppBar(
        title: const Text("Secure Your Account in Seconds", style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Upload Your Bank Passbook", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: (_selectedFile != null || _webFile != null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: kIsWeb
                              ? Image.network(_webFile!.path)
                              : Image.file(
                                  _selectedFile!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add, size: 32, color: Colors.grey),
                            SizedBox(height: 8),
                            Text("+ Upload Image", style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 8),
              const Text("Only JPG, PNG, or PDF files. Max size: 5 MB", style: TextStyle(fontSize: 12, color: Colors.black)),
              const Spacer(),
              ElevatedButton(
                onPressed: isUploading ? null : _uploadPassbook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Save", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
