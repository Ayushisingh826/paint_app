import 'package:flutter/material.dart';
import 'package:paint_app/screens/profile/profile_screen.dart'; // Make sure this has showEditDialog()

class KycCard extends StatefulWidget {
  const KycCard({Key? key}) : super(key: key);

  @override
  State<KycCard> createState() => _KycCardState();
}

class _KycCardState extends State<KycCard> {
  final Map<String, String> _kycDetails = {
    "Pancard": "",
    "Aadhar Card": "",
  };

  final Map<String, bool> _isVerified = {
    "Pancard": false,
    "Aadhar Card": false,
  };

  void _verifyDetail(String key) async {
    String? result = await showEditDialog(context, "Enter your $key", _kycDetails[key]!);
    if (result != null && result.isNotEmpty) {
      setState(() {
        _kycDetails[key] = result;
        _isVerified[key] = true; // Mark as verified after successful input
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$key Verified Successfully')),
      );
    }
  }

  Widget buildInfoRow(String label, String value, VoidCallback onVerify) {
    bool verified = _isVerified[label] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          Row(
            children: [
              verified
                  ? const Text("Verified ✅", style: TextStyle(color: Colors.green))
                  : Text(value.isNotEmpty ? value : "---"),
              const SizedBox(width: 4),
              if (!verified)
                IconButton(
                  icon: const Icon(Icons.verified, size: 18, color: Colors.blue),
                  tooltip: 'Verify',
                  onPressed: onVerify,
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.lightBlue,),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("KYC", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const Divider(thickness: 1, color: Colors.black),
          ..._kycDetails.entries.map(
            (entry) => buildInfoRow(entry.key, entry.value, () => _verifyDetail(entry.key)),
          ),
        ],
      ),
    );
  }
}
