import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/cart/cart_controller.dart';
import 'package:haly/app/modules/order/order_controller.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:haly/app/theme/theme/theme_colors.dart';
import 'package:haly/app/modules/bottomnavbar/bottom_nav_bar_controller.dart';

import '../about_us/controller.dart';
import '../contacted/contacted_controller.dart';
import '../profile/controller/profile_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});

  final BottomNavBarController controller = Get.put(BottomNavBarController());
  final ContactedController contactedController =
      Get.put(ContactedController());
  final AboutController aboutController = Get.put(AboutController());
  final ProfileController profileController = Get.put(ProfileController());
  final CartController cartController = Get.find<CartController>();

  BottomNavigationBarItem buildNavItem({
    required String selectedIconPath,
    required String unselectedIconPath,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (index == 2)
            Obx(() {
              final count = cartController.cartItems.length;
              return count > 0
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 231, 63, 63),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        count.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 9,
                            fontFamily: Fonts.gilroySemiBold),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : const SizedBox(height: 22);
            })
          else if (index == 3)
            Obx(() {
              final count = orderController.orders.length;
              return count > 0
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 231, 63, 63),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        count.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 9,
                            fontFamily: Fonts.gilroySemiBold),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : const SizedBox(height: 22);
            })
          else
            const SizedBox(height: 22),
          Obx(() {
            final isSelected = controller.selectedIndex.value == index;
            return SvgPicture.asset(
              isSelected ? selectedIconPath : unselectedIconPath,
              width: 32,
              height: 32,
            );
          }),
        ],
      ),
      label: label,
    );
  }

  final OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: screens,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                currentIndex: controller.selectedIndex.value,
                onTap: (index) => controller.changeIndex(index),
                selectedItemColor: AppColors.green,
                unselectedItemColor: const Color.fromARGB(255, 129, 129, 129),
                selectedLabelStyle: const TextStyle(
                  fontFamily: Fonts.gilroyMedium,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: Fonts.gilroyRegular,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                items: [
                  buildNavItem(
                    selectedIconPath: Assets.homeActive,
                    unselectedIconPath: Assets.home,
                    label: 'Baş Sahypa',
                    index: 0,
                  ),
                  buildNavItem(
                    selectedIconPath: Assets.gozlegActive,
                    unselectedIconPath: Assets.gozleg,
                    label: 'Gözleg',
                    index: 1,
                  ),
                  buildNavItem(
                    selectedIconPath: Assets.sebetActive,
                    unselectedIconPath: Assets.sebet,
                    label: 'Sebet',
                    index: 2,
                  ),
                  buildNavItem(
                    selectedIconPath: Assets.tassyklaActive,
                    unselectedIconPath: Assets.tassykla,
                    label: 'Tassyklananlar',
                    index: 3,
                  ),
                  buildNavItem(
                    selectedIconPath: Assets.userActive,
                    unselectedIconPath: Assets.user,
                    label: 'Profil',
                    index: 4,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
