import 'package:flutter/material.dart';
import 'package:haly/app/theme/theme/app_theme.dart';

class AboutUsImages extends StatelessWidget {
  final bool isTablet;

  const AboutUsImages({super.key, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: isTablet ? 283 : 100,
            child: Image.asset(Assets.about1, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: isTablet ? 20 : 10),
        Expanded(
          child: SizedBox(
            height: isTablet ? 283 : 100,
            child: Image.asset(Assets.about2, fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
