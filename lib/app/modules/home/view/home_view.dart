import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/home/controller/home_controller.dart';
import 'package:haly/app/modules/home/widgets/home_app_bar.dart';
import 'package:haly/app/modules/home/widgets/home_carpet_grid.dart';
import 'package:haly/app/theme/theme/app_theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: const HomeAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if (controller.carpetData.value == null ||
                      controller.carpetData.value!.categories.isEmpty) {
                    return const SizedBox.shrink();
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HALY GÖRNÜŞLERI',
                          style: TextStyle(
                              fontSize: isTablet ? 24 : 18,
                              color: Colors.black,
                              fontFamily: Fonts.gilroySemiBold,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }
                }),
                HomeCarpetGrid(isTablet: isTablet),
              ],
            ),
          );
        },
      ),
    );
  }
}
