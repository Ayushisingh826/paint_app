import 'package:flutter/material.dart';
import 'package:paint_app/screens/profile/profile_screen.dart';
import 'package:paint_app/screens/profile/upload_passbook_screen.dart'; // Ensure this has `showEditDialog`

class BankDetailsCard extends StatefulWidget {
  const BankDetailsCard({Key? key}) : super(key: key);

  @override
  State<BankDetailsCard> createState() => _BankDetailsCardState();
}

class _BankDetailsCardState extends State<BankDetailsCard> {
  final Map<String, String> _bankDetails = {
    "Account Number": "",
    "Account Holder": "",
    "Bank Name": "",
    "IFSC ":"",
    "Passbook":"",
  };

  void _editDetail(String key) async {
  if (key == "Passbook") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const UploadPassbookScreen()),
    );
    return;
  }

  String? result = await showEditDialog(context, key, _bankDetails[key]!);
  if (result != null && result.isNotEmpty) {
    setState(() {
      _bankDetails[key] = result;
    });
  }
}

  Widget buildInfoRow(String label, String value, VoidCallback onEdit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 18, color: Colors.black),
            onPressed: onEdit,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : '---',
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.black),
            ),
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
          const Text("Bank details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const Divider(thickness: 1,color: Colors.black,),
          ..._bankDetails.entries.map((entry) =>
              buildInfoRow(entry.key, entry.value, () => _editDetail(entry.key))),
        ],
      ),
    );
  }
}
