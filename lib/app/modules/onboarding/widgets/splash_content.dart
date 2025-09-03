import 'package:flutter/material.dart';
import 'package:haly/app/modules/onboarding/widgets/splash_text_gradient.dart';
import 'package:haly/app/theme/theme/app_theme.dart';

class SplashContent extends StatelessWidget {
  final bool isTablet;

  const SplashContent({super.key, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Assets.logo,
            width: isTablet ? 313.62 : 200,
            height: isTablet ? 193 : 100,
          ),
          Container(
            padding: EdgeInsets.only(left: isTablet ? 210 : 20),
            alignment: Alignment.center,
            child: GradientText(
              text: 'Owadan haly...',
              style: TextStyle(
                fontSize: isTablet ? 30 : 18,
                fontFamily: Fonts.script,
                fontWeight: FontWeight.w700,
              ),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(0, 147, 61, 1),
                  Color.fromRGBO(0, 0, 0, 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
