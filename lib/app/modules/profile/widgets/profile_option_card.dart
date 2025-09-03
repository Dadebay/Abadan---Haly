import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';

class ProfileOptionCard extends StatelessWidget {
  final String title;
  final IconData iconPath;
  final RxBool isLoading;

  const ProfileOptionCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 247, 247),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromARGB(255, 247, 247, 247)),
      ),
      child: Column(children: [
        Row(
          children: [
            Obx(() => isLoading.value
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: Lottie.asset('assets/images/processing-circle.json'),
                  )
                : HugeIcon(
                    icon: iconPath,
                    size: 35,
                    color: Colors.green,
                  )),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: Fonts.gilroySemiBold,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
