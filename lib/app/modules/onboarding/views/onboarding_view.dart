// ui/onboarding_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/onboarding/controller/onboarding_controller.dart';
import 'package:haly/app/modules/onboarding/widgets/onboarding_navigation_buttons.dart';
import 'package:haly/app/modules/onboarding/widgets/onboarding_page.dart';
import 'package:haly/app/modules/onboarding/widgets/onboarding_page_indicator.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController controller = Get.put(OnboardingController());

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/onboarding1.jpg',
      'title': 'Abadan hala hoş geldiňiz',
      'desc':
          'Döwrebap nusgawy dizaýnlarda — stiliňize, giňişligiňize laýyk gelýän halylary biz bilen saýlaň.',
    },
    {
      'image': 'assets/images/onboarding2.jpg',
      'title': 'Öýüňiziň bezegi -Abadan haly',
      'desc': 'Dürli görnüşdäki halylar',
    },
    {
      'image': 'assets/images/onboarding3.jpg',
      'title': 'Sargyt ediň',
      'desc':
          'Ykjam goşundy arkaly oturan ýeriňizden islendik görnüşdäki halylary sargyt ediň.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return Center(
              child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Lottie.asset('assets/images/processing-circle.json')));
        }

        final bool useApiData =
            controller.intros.isNotEmpty && !controller.hasError.isTrue;
        final int itemCount =
            useApiData ? controller.intros.length : onboardingData.length;

        return LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;
            return Column(
              children: [
                Expanded(
                  flex: 10,
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: (index) =>
                        controller.currentPage.value = index,
                    itemCount: itemCount,
                    itemBuilder: (_, index) {
                      if (useApiData) {
                        final introItem = controller.intros[index];
                        return OnboardingPage(
                          isTablet: isTablet,
                          imageWidget: File(introItem.image).existsSync()
                              ? Image.file(
                                  File(introItem.image),
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image_not_supported),
                          title: introItem.title,
                          desc: introItem.description,
                        );
                      } else {
                        return OnboardingPage(
                          isTablet: isTablet,
                          imageWidget: Image.asset(
                            onboardingData[index]['image']!,
                            fit: BoxFit.cover,
                          ),
                          title: onboardingData[index]['title']!,
                          desc: onboardingData[index]['desc']!,
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 70.0 : 12.0,
                        vertical: isTablet ? 20.0 : 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: OnboardingPageIndicator(
                            controller: controller,
                            pageCount: itemCount,
                          ),
                        ),
                        const SizedBox(height: 10),
                        OnboardingNavigationButtons(
                          controller: controller,
                          isTablet: isTablet,
                          totalPages: itemCount,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
