import 'package:flutter/material.dart';
import 'package:haly/app/theme/theme/app_theme.dart';

class ContactCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final bool isTablet;

  const ContactCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isTablet ? 144 : 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(244, 244, 244, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: isTablet ? 24 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: Fonts.gilroySemiBold,
                    fontSize: isTablet ? 16 : 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: isTablet ? 16 : 14,
                    color: const Color.fromRGBO(111, 110, 110, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
