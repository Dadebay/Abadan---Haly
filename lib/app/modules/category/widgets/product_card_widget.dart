import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/data/carpet_model.dart';
import 'package:haly/app/modules/category/widgets/product_card_widget_controller.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:haly/app/theme/theme/theme_colors.dart';

import '../../produts/view/product_detail_view.dart';

class ProductCardWidget extends GetView<ProductCardWidgetController> {
  final Product product;

  ProductCardWidget({super.key, required this.product}) {
    Get.put(ProductCardWidgetController(product: product), tag: product.id.toString());
  }

  @override
  String? get tag => product.id.toString();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
            () => ProductDetailView(
                  product: product,
                  category: controller.category.value,
                ),
            preventDuplicates: false);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(1),
          border: Border.all(
            color: const Color.fromARGB(255, 231, 231, 231),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // PhotoView(
            //             imageProvider: FileImage(
            //               File(product.figures.first.colors.first.image),
            //             ),
            //             minScale: PhotoViewComputedScale.contained,
            //             maxScale: PhotoViewComputedScale.covered * 4,
            //             backgroundDecoration: const BoxDecoration(color: Colors.white),
            //           )
            Expanded(
              flex: 5,
              child: (product.figures.isNotEmpty && product.figures.first.colors.isNotEmpty)
                  ? Image.file(
                      File(product.figures.first.colors.first.image),
                      fit: BoxFit.fitHeight,
                    )
                  : Image.asset(
                      'assets/images/card1.png', // Placeholder image
                      fit: BoxFit.cover,
                    ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                          controller.category.value?.name ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: Fonts.gilroySemiBold,
                            fontSize: 20,
                          ),
                        )),
                    Text(
                      product.code,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: Fonts.gilroyMedium,
                        fontSize: 16,
                        color: Color.fromARGB(255, 110, 110, 112),
                      ),
                    ),
                    Text(
                      (product.figures.isNotEmpty && product.figures.first.colors.isNotEmpty) ? product.figures.first.colors.first.name : '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: Fonts.gilroyMedium,
                        fontSize: 16,
                        color: Color.fromARGB(255, 110, 110, 112),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 3,
                        right: 3,
                        bottom: 3,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(
                                () => ProductDetailView(
                                      product: product,
                                      category: controller.category.value,
                                    ),
                                preventDuplicates: false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            // minimumSize: Size.fromHeight(44),
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text(
                            "Görmek",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
