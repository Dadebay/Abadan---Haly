import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/bottomnavbar/bottom_nav_bar.dart';

import '../../../data/carpet_model.dart';
import '../../../data/data_service.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  var currentPage = 0.obs;

  void nextPage(int totalPages) {
    if (currentPage.value < totalPages - 1) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Get.off(CustomBottomNavBar());
    }
  }

  final DataService _dataService = Get.put(DataService());

  var intros = <Intro>[].obs;

  final isLoading = true.obs;
  final hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchIntros();
  }

  void fetchIntros() async {
    try {
      isLoading(true);
      hasError(false);

      final fetchedIntros = await _dataService.getIntros();

      if (fetchedIntros.isNotEmpty) {
        intros.value = fetchedIntros;
      }
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }
}
