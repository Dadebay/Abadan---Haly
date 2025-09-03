import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/bottomnavbar/bottom_nav_bar.dart';
import 'package:haly/app/modules/onboarding/controller/onboarding_controller.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:haly/app/theme/theme/theme_colors.dart';

class OnboardingNavigationButtons extends StatelessWidget {
  final OnboardingController controller;
  final bool isTablet;
  final int totalPages;

  const OnboardingNavigationButtons({
    super.key,
    required this.controller,
    required this.isTablet,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: isTablet ? 60 : 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadii.borderRadius12,
              ),
            ),
            onPressed: () => controller.nextPage(totalPages),
            child: Text(
              'Dowam et',
              style: TextStyle(fontSize: isTablet ? 20 : 16, fontWeight: FontWeight.w600, fontFamily: Fonts.gilroySemiBold, color: Colors.white),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.off(CustomBottomNavBar());
          },
          child: Text(
            'Göni geçmek',
            style: TextStyle(color: const Color.fromARGB(255, 39, 39, 40), fontWeight: FontWeight.w600, fontFamily: Fonts.gilroySemiBold, fontSize: isTablet ? 20 : 16),
          ),
        )
      ],
    );
  }
}
