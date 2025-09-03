import 'dart:io';
import 'package:flutter/material.dart';
import 'package:haly/app/theme/theme/app_theme.dart';

class CarpetCard extends StatelessWidget {
  final String title;
  final Gradient gradient;
  final String image;
  final bool isTablet;
  final VoidCallback? onTap;

  const CarpetCard({
    super.key,
    required this.title,
    required this.gradient,
    required this.image,
    this.isTablet = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(
          File(image),
          width: isTablet ? 200 : 120,
          height: isTablet ? 180 : 120,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
