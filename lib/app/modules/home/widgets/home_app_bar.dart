import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/about_us/about_us_view.dart';
import 'package:haly/app/modules/contacted/contacted_view.dart';
import 'package:haly/app/theme/theme/app_theme.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      elevation: 0,
      title: Image.asset(
        Assets.logo,
        height: 80,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.to(AboutUsView());
            },
            child: const Text("Biz barada",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: Fonts.gilroySemiBold,
                    fontSize: 24,
                    fontWeight: FontWeight.w600))),
        TextButton(
            onPressed: () {
              Get.to(ContactScreen());
            },
            child: const Text("Habarlaşmak",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: Fonts.gilroySemiBold,
                    fontSize: 24,
                    fontWeight: FontWeight.w600))),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
