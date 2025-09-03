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
      padding: EdgeInsets.only(
        left: isTablet ? 10 : 4,
        top: isTablet ? 5 : 4,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected
              ? const Color.fromARGB(255, 185, 215, 135)
              : const Color(0xFFE0E0E0),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: isTablet ? 18 : 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: Fonts.gilroySemiBold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: isTablet ? 10 : 4,
            ),
            child: Image.file(
              File(imagePath),
              width: isTablet ? 140 : 40,
              height: isTablet ? 140 : 40,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    ),
  );
}
