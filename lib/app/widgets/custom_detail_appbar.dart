import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:hugeicons/hugeicons.dart'; // HugeIcons eklendi

class ProductDetailAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductDetailAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                HugeIcons.strokeRoundedArrowLeft01,
                size: 30,
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Get.back();
              },
            ),
            Expanded(
              child: Center(
                child: Image.asset(
                  Assets.logo,
                  height: 74,
                  width: 120,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}
