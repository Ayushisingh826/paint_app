import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';


class KycCard extends StatefulWidget {
  const KycCard({Key? key}) : super(key: key);

  @override
  State<KycCard> createState() => _KycCardState();
}

class _KycCardState extends State<KycCard> {
  String? panPhotoUrl;
  String? aadharPhotoUrl;
  bool isPanVerified = false;
  bool isAadharVerified = false;
  bool isUploadingPan = false;
  bool isUploadingAadhar = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _uploadPanCard() async {
    setState(() => isUploadingPan = true);
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        await uploadDocument(image, 'panPhoto', 'https://kkd-backend-api.onrender.com/api/user/upload-pan', isPan: true);
      }
    } finally {
      setState(() => isUploadingPan = false);
    }
  }

  Future<void> _uploadAadharCard() async {
    setState(() => isUploadingAadhar = true);
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        await uploadDocument(image, 'aadharPhoto', 'https://kkd-backend-api.onrender.com/api/user/upload-aadhar', isPan: false);
      }
    } finally {
      setState(() => isUploadingAadhar = false);
    }
  }

  Future<void> uploadDocument(XFile image, String fieldName, String endpoint, {required bool isPan}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null) throw Exception("No token found");

      var uri = Uri.parse(endpoint);
      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token';

      http.MultipartFile multipartFile;
      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        multipartFile = http.MultipartFile.fromBytes(
          fieldName,
          bytes,
          filename: image.name,
          contentType: MediaType('image', 'jpeg'),
        );
      } else {
        multipartFile = await http.MultipartFile.fromPath(
          fieldName,
          image.path,
          contentType: MediaType('image', 'jpeg'),
        );
      }

      request.files.add(multipartFile);
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("📦 Raw response body: ${response.body}");
      print("📦 Status code: ${response.statusCode}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ ${isPan ? 'PAN' : 'Aadhar'} uploaded successfully")),
        );

        setState(() {
          if (isPan) {
            panPhotoUrl = data['data']['panPhoto'];
            isPanVerified = data['data']['isPanVerified'];
          } else {
            aadharPhotoUrl = data['data']['aadharPhoto'];
            isAadharVerified = data['data']['isAadharVerified'];
          }
        });
      } else {
        throw Exception(data['message'] ?? "Upload failed");
      }
    } catch (e) {
      print("❌ Upload Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.lightBlue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("KYC", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const Divider(thickness: 1, color: Colors.black),
          _buildUploadRow("PAN Card", isUploadingPan, _uploadPanCard, panPhotoUrl, isPanVerified),
          const SizedBox(height: 8),
          _buildUploadRow("Aadhar Card", isUploadingAadhar, _uploadAadharCard, aadharPhotoUrl, isAadharVerified),
        ],
      ),
    );
  }

  Widget _buildUploadRow(String label, bool isUploading, VoidCallback onUpload, String? imageUrl, bool isVerified) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            isUploading
                ? const CircularProgressIndicator(strokeWidth: 2)
                : ElevatedButton(
                    onPressed: onUpload,
                    child: const Text("Upload"),
                  ),
          ],
        ),
        if (imageUrl != null) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  height: 80,
                  width: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                isVerified ? "✅ Verified" : "❌ Not Verified",
                style: TextStyle(
                  color: isVerified ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ]
      ],
    );
  }
}