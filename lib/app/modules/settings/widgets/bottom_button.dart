import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/settings/settings_controller.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:haly/app/theme/theme/theme_colors.dart';

class BottomButton extends StatelessWidget {
  BottomButton({super.key});
  final SettingsController controller = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.saveDomain,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Domeni üýtget",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: Fonts.gilroySemiBold)),
            ),
          ),
        ),
      ],
    );
  }
}
