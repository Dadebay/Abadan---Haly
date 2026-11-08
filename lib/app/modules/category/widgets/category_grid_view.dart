import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/category/controller/category_controller.dart';
import 'package:haly/app/modules/category/widgets/product_card_widget.dart';

class CategoryGridView extends StatelessWidget {
  final bool isTablet;

  const CategoryGridView({super.key, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.find();
    final selectedSubcategory = controller
        .category.value!.subcategories[controller.selectedTabIndex.value];
    final filteredProducts = controller.products
        .where((p) => p.subCategoryId == selectedSubcategory.id)
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 493,
        child: GridView.builder(
          itemCount: filteredProducts.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 231,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 260 / 600,
          ),
          itemBuilder: (context, index) {
            return ProductCardWidget(product: filteredProducts[index]);
          },
        ),
      ),
    );
  }
}
