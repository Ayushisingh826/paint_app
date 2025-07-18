import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:paint_app/screens/QrScanner/usedQr_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paint_app/screens/QrScanner/result_screen.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  bool isScanCompleted = false;
  final MobileScannerController controller = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
  }
String formatDate(String isoDate) {
  try {
    final dateTime = DateTime.parse(isoDate).toLocal();
    return "${dateTime.day} ${_monthName(dateTime.month)} ${dateTime.year}, ${_formatTime(dateTime)}";
  } catch (_) {
    return isoDate;
  }
}

String _monthName(int month) {
  const months = [
    '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return months[month];
}

String _formatTime(DateTime dt) {
  final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour;
  final period = dt.hour >= 12 ? "PM" : "AM";
  return "${hour}:${dt.minute.toString().padLeft(2, '0')} $period";
}

  Future<void> handleQRScan(String qrData) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token == null) throw Exception("No token found");

    // Try decoding first to validate it's a valid JSON
    late String encodedQrData;
    try {
      final decoded = jsonDecode(qrData); // this will throw if not valid
      encodedQrData = jsonEncode(decoded); // ensures it's properly encoded
    } catch (_) {
      throw Exception("Invalid QR code format.");
    }

    final uri = Uri.parse('https://kkd-backend-api.onrender.com/api/user/scan-qr');
    final body = jsonEncode({'qrData': encodedQrData});
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(uri, body: body, headers: headers);

    print("🔍 API Status: ${response.statusCode}");
    print("📦 Response: ${response.body}");

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200 && responseData['success'] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            closeScreen: closeScreen,
            code: jsonEncode(responseData['data']),
          ),
        ),
      );
    } else if (responseData['message']?.toString().toLowerCase().contains("already been used") ?? false) {
  final usedBy = responseData['data']?['scannedByName'] ?? 'Unknown';
  final usedOn = formatDate(responseData['data']?['scannedAt'] ?? '');

Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => UsedQrScreen(
        name: usedBy,
        date: usedOn,
        closeScreen: closeScreen,
      ),
    ),
  );

    } else {
      throw Exception(responseData['message'] ?? 'QR scan failed');
    }
  } catch (e) {
    print("❌ QR Scan Error: $e");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
  }
}


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (barcodeCapture) async {
              if (!isScanCompleted && barcodeCapture.barcodes.isNotEmpty) {
                final code = barcodeCapture.barcodes.first.rawValue ?? '';
                isScanCompleted = true;
                await controller.stop(); // ✅ Stop camera to prevent warnings
                await handleQRScan(code);
              }
            },
          ),

          // ❌ Close Button
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.close, color: Colors.white, size: 30),
            ),
          ),

          // ✅ Border Frame
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
              child: CustomPaint(painter: ScanBorderPainter()),
            ),
          ),

          // ⚡ Flash / Gallery Placeholder Icons
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.flash_on, color: Colors.white, size: 28),
                SizedBox(width: 30),
                Icon(Icons.image, color: Colors.white, size: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for scanner brackets
class ScanBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    const double cornerLength = 30;

    // Top Left
    canvas.drawLine(Offset(0, 0), Offset(cornerLength, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, cornerLength), paint);

    // Top Right
    canvas.drawLine(Offset(size.width, 0), Offset(size.width - cornerLength, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, cornerLength), paint);

    // Bottom Left
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - cornerLength), paint);
    canvas.drawLine(Offset(0, size.height), Offset(cornerLength, size.height), paint);

    // Bottom Right
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width, size.height - cornerLength), paint);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width - cornerLength, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
