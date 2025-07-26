import 'package:flutter/material.dart';

class ProfileLinearSegmentedBar extends StatelessWidget {
  final int completedSections;
  final int totalSections;

  const ProfileLinearSegmentedBar({
    super.key,
    required this.completedSections,
    this.totalSections = 3,
  });

  @override
  Widget build(BuildContext context) {
    const double barHeight = 8;
    const double gap = 6;

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final segmentWidth = (totalWidth - ((totalSections - 1) * gap)) / totalSections;

        return SizedBox(
          height: barHeight,
          child: Row(
            children: List.generate(totalSections, (index) {
              final isCompleted = index < completedSections;
              return Container(
                width: segmentWidth,
                height: barHeight,
                margin: EdgeInsets.only(right: index != totalSections - 1 ? gap : 0),
                decoration: BoxDecoration(
                  color: isCompleted ? const Color(0xFF8A98F3) : Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade300),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
