import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/profile/controller/profile_controller.dart';
import 'package:haly/app/theme/theme/app_theme.dart';

class ImportProgressDialog extends StatelessWidget {
  final ProfileController controller;
  final bool isOrderUpload;

  const ImportProgressDialog({
    super.key,
    required this.controller,
    this.isOrderUpload = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isOrderUpload
                  ? 'Sargytlar ugradylýar...'
                  : 'Maglumatlar ýüklenýär...',
              style: const TextStyle(
                fontSize: 18,
                fontFamily: Fonts.gilroySemiBold,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            if (isOrderUpload)
              LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                minHeight: 10,
              )
            else
              Obx(() => Column(
                    children: [
                      LinearProgressIndicator(
                        value: controller.downloadProgress.value,
                        backgroundColor: Colors.grey[200],
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.green),
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
                  )),
          ],
        ),
      ),
    );
  }
}
