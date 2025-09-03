import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/home/controller/home_controller.dart';
import 'package:haly/app/modules/category/view/category_view.dart';
import 'package:haly/app/modules/home/widgets/carpet_card.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';

class HomeCarpetGrid extends StatelessWidget {
  final bool isTablet;

  const HomeCarpetGrid({super.key, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: SizedBox(width: 40, height: 40, child: Lottie.asset('assets/images/processing-circle.json')));
        } else if (controller.hasError.value) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedCloudDownload,
                    size: 70,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Haryt tapylmady',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: Fonts.gilroySemiBold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Maglumatlary profil sahypasyndan ýükläp almagyňyzy haýyş edýäris.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w500, fontFamily: Fonts.gilroyMedium),
                  ),
                ],
              ),
            ),
          );
        } else if (controller.carpetData.value == null || controller.carpetData.value!.categories.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedCloudDownload,
                    size: 70,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Haryt tapylmady',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: Fonts.gilroySemiBold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Maglumatlary profil sahypasyndan ýükläp almagyňyzy haýyş edýäris.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w500, fontFamily: Fonts.gilroyMedium),
                  ),
                ],
              ),
            ),
          );
        } else {
          final categories = controller.carpetData.value!.categories;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isTablet ? 2 : 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.70,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              const defaultGradient = LinearGradient(colors: [
                Color.fromARGB(255, 168, 168, 168),
                Color.fromARGB(255, 135, 129, 129),
              ]);
              final gradients = [
                const LinearGradient(colors: [
                  Color.fromRGBO(59, 94, 164, 1),
                  Color.fromRGBO(49, 76, 132, 1),
                ]),
                const LinearGradient(colors: [
                  Color.fromRGBO(201, 53, 19, 1),
                  Color.fromRGBO(117, 33, 14, 1),
                ]),
                const LinearGradient(colors: [
                  Color.fromRGBO(97, 113, 71, 1),
                  Color.fromRGBO(185, 215, 135, 1),
                ]),
              ];
              final gradient = index == 0 ? defaultGradient : gradients[(index - 1) % gradients.length];

              return CarpetCard(
                title: category.name,
                gradient: gradient,
                image: category.image,
                isTablet: isTablet,
                onTap: () => Get.to(() => CategoryView(title: category.name)),
              );
            },
          );
        }
      }),
    );
  }
}
