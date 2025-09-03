import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/profile/controller/profile_controller.dart';
import 'package:haly/app/theme/theme/app_theme.dart';

class ImportProgressDialog extends StatelessWidget {
  final ProfileController controller;

  const ImportProgressDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Maglumatlar ýüklenýär...',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: Fonts.gilroySemiBold,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              LinearProgressIndicator(
                value: controller.downloadProgress.value,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                minHeight: 10,
              ),
              const SizedBox(height: 10),
              Text(
                '${(controller.downloadProgress.value * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: Fonts.gilroyMedium,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
