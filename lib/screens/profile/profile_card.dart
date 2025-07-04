import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage("assets/images/logo.png"),
          radius: 40,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Esther Howard", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text("Contractor", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
