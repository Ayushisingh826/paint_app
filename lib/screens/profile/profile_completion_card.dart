import 'package:flutter/material.dart';
import 'package:paint_app/screens/profile/profile_linear_segmentbar.dart';

class ProfileCompletionCard extends StatelessWidget {
  final int completedSections;
  final int totalSections;

  const ProfileCompletionCard({
    Key? key,
    required this.completedSections,
    this.totalSections = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1CD8D2), Color(0xFF93EDC7)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blueAccent, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Complete your profile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 4),
          const Text(
            "This helps build trust, encouraging members",
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 10),
          Text(
            "$completedSections out of $totalSections complete",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 6),
          ProfileLinearSegmentedBar(
            completedSections: completedSections,
            totalSections: totalSections,
          ),
        ],
      ),
    );
  }
}
