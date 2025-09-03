import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haly/app/data/data_service.dart';
import 'package:haly/app/data/carpet_model.dart';
import 'package:haly/app/modules/contacted/contacted_controller.dart';
import 'package:haly/app/modules/home/controller/home_controller.dart';
import 'package:haly/app/modules/order/order_controller.dart';
import 'package:haly/app/modules/onboarding/controller/onboarding_controller.dart';
import 'package:haly/app/modules/search/controller/search_controller.dart'
    as search_controller;
import 'package:haly/app/modules/profile/widgets/import_progress_dialog.dart';
import 'package:haly/app/data/carpet_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hugeicons/hugeicons.dart';
import '../../about_us/controller.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  final DataService dataService = DataService();
  final RxDouble downloadProgress = 0.0.obs;
  final _box = GetStorage();

  String get domain => _box.read('domain') ?? 'https://carpet.sada-devs.com';

  Future<void> importData() async {
    Get.dialog(
      ImportProgressDialog(controller: this),
      barrierDismissible: false,
    );

    try {
      await dataService.importDataFromApi(onProgress: (progress) {
        downloadProgress.value = progress;
      });
      if (!Get.isRegistered<HomeController>()) {
        Get.put(HomeController());
      }
      if (!Get.isRegistered<OnboardingController>()) {
        Get.put(OnboardingController());
      }
      if (!Get.isRegistered<ContactedController>()) {
        Get.put(ContactedController());
      }
      if (!Get.isRegistered<AboutController>()) {
        Get.put(AboutController());
      }
      if (!Get.isRegistered<SearchController>()) {
        Get.put(SearchController());
      }
      Get.find<HomeController>().fetchCarpetData();
      Get.find<ContactedController>().fetchContacts();
      Get.find<AboutController>().fetchAbout();
      Get.find<OnboardingController>().fetchIntros();

      if (Get.isRegistered<search_controller.SearchController>()) {
        Get.find<search_controller.SearchController>().fetchData();
      }
      Get.back();
      Get.snackbar(
        'Üstünlikli Tamamlandy',
        "Maglumatlar üstünlikli ýüklenildi!",
        icon: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedCloudDownload,
            size: 28,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(15),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Internet Baglanyşygy Ýok',
        "Maglumatlary ýüklemek başartmady. Internet baglanyşygyňyzy barlaň.",
        icon: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedWifiOff01,
            size: 28,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(15),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      print("asibka   $e");
    } finally {
      downloadProgress.value = 0.0;
    }
  }

  Future<void> uploadOrders() async {
    final OrderController orderController = Get.find<OrderController>();
    final carpetData =
        await dataService.getCarpetData(); // Fetch carpetData here
    if (orderController.orders.isEmpty) {
      Get.snackbar(
        'Ýalňyşlyk',
        "Ugradylýan tassyklama ýok!",
        icon: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedWifiOff01,
            size: 28,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(15),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );

      return;
    }

    try {
      Get.dialog(
        ImportProgressDialog(controller: this),
        barrierDismissible: false,
      );
      final List<Map<String, dynamic>> ordersToUpload = [];
      for (var order in orderController.orders) {
        for (var item in order.items) {
          ordersToUpload.add({
            "order_id": order.id,
            "category": carpetData.categories
                .firstWhere((c) => c.id == item.product.categoryId)
                .name,
            "product_code": item.product.code,
            "size": item.size,
            "color": item.colorName,
            "figure": item.product.figures.first.name,
            "edge": item.edge,
            "note": item.note,
            "quantity": item.quantity.toString(),
          });
        }
      }

      final url = Uri.parse('$domain/api/sync/orders');
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode(ordersToUpload);
      for (int i = 0; i <= 100; i += 10) {
        downloadProgress.value = i / 100.0;
        await Future.delayed(const Duration(milliseconds: 100));
      }

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar(
          'Üstünlikli Tamamlandy',
          "Tassyklama üstünlikli ugradyldy",
          icon: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedCloudDownload,
              size: 28,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green.shade600,
          colorText: Colors.white,
          borderRadius: 12,
          margin: const EdgeInsets.all(15),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack,
        );
        orderController.orders.clear();
      } else {
        Get.back();
        Get.snackbar(
          'Internet Baglanyşygy Ýok',
          "Maglumatlary ýüklemek başartmady. Internet baglanyşygyňyzy barlaň.",
          icon: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedWifiOff01,
              size: 28,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white,
          borderRadius: 12,
          margin: const EdgeInsets.all(15),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Internet Baglanyşygy Ýok',
        "Maglumatlary ýüklemek başartmady. Internet baglanyşygyňyzy barlaň.",
        icon: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedWifiOff01,
            size: 28,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(15),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    } finally {
      downloadProgress.value = 0.0;
    }
  }
}
