import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/data/data_service.dart';
import 'package:haly/app/data/carpet_model.dart';

class CategoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final DataService dataService = DataService();
  final String categoryName;
  var isLoading = true.obs;
  var isTabControllerReady = false.obs;
  var category = Rxn<Category>();
  var products = <Product>[].obs;
  var selectedTabIndex = 0.obs;
  late TabController tabController;

  CategoryController({required this.categoryName});

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading(true);
      CarpetData carpetData = await dataService.getCarpetData();
      category.value =
          carpetData.categories.firstWhere((c) => c.name == categoryName);
      products.value = carpetData.products
          .where((p) =>
              carpetData.categories
                  .firstWhere((c) => c.id == p.categoryId)
                  .name ==
              categoryName)
          .toList();
      if (category.value != null && category.value!.subcategories.isNotEmpty) {
        tabController = TabController(
            length: category.value!.subcategories!.length, vsync: this);
        isTabControllerReady.value = true;
      }
    } finally {
      isLoading(false);
    }
  }

  void changeTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  @override
  void onClose() {
    if (isTabControllerReady.value) {
      tabController.dispose();
    }
    super.onClose();
  }
}
