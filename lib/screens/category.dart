import 'package:flutter/material.dart';
import 'package:paint_app/screens/colors.dart';

class CategoryItem extends StatelessWidget {
  final String name;
  final String imagePath;

  const CategoryItem({
    Key? key,
    required this.name,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 30,
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.fontcolor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
