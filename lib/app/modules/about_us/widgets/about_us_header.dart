import 'package:flutter/material.dart';
import 'package:haly/app/theme/theme/app_theme.dart';

class AboutUsHeader extends StatelessWidget {
  const AboutUsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 4,
          width: double.infinity,
          color: const Color.fromRGBO(245, 245, 245, 1),
        ),
        const SizedBox(height: 24),
        Center(
          child: Image.asset(
            Assets.logo,
            height: 102,
            width: 166,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
