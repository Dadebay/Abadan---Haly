import 'dart:io';
import 'package:flutter/material.dart';
import 'package:haly/app/theme/theme/app_theme.dart';

Widget buildCustomTab(
  BuildContext context,
  String title,
  String imagePath, {
  bool isSelected = false,
  bool isTablet = false,
}) {
  final tabWidth = MediaQuery.of(context).size.width / 3 - 20;
  final tabHeight = isTablet ? 83.0 : 60.0;

  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Container(
      height: tabHeight,
      width: tabWidth,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? const Color.fromARGB(255, 185, 215, 135) : const Color(0xFFE0E0E0),
          width: isSelected ? 3 : 2,
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
