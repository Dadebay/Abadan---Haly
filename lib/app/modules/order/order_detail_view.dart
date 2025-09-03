import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/data/order_model.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:haly/app/widgets/custom_app_bar_logo.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:haly/app/modules/order/order_detail_view_controller.dart';
import 'package:lottie/lottie.dart';

class OrderDetailView extends GetView<OrderDetailViewController> {
  final Order order;

  const OrderDetailView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderDetailViewController());
    return Scaffold(
      appBar: customAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              IconButton(
                icon: const Icon(
                  HugeIcons.strokeRoundedArrowLeft01,
                  size: 30,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                'Order ID (${order.id})',
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: Fonts.gilroySemiBold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]),
            const SizedBox(height: 10),
            Container(
              height: 4,
              color: const Color.fromRGBO(245, 245, 245, 1),
            ),
            const SizedBox(height: 20),
            Obx(
              () {
                if (controller.isLoading.value) {
                  return Center(
                      child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Lottie.asset(
                              'assets/images/processing-circle.json')));
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: order.items.length,
                    itemBuilder: (context, index) {
                      final item = order.items[index];
                      return Container(
                        height: 349,
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1),
                              child: Image.file(
                                File(item.imageUrl),
                                width: 230,
                                height: 329,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 25),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      controller.getCategoryName(
                                          item.product.categoryId),
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: Fonts.gilroySemiBold)),
                                  const SizedBox(height: 6),
                                  Text("Kody: ${item.product.code}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: Fonts.gilroyMedium)),
                                  const SizedBox(height: 6),
                                  Text("Kenary: ${item.edge}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: Fonts.gilroyMedium)),
                                  const SizedBox(height: 6),
                                  Text("Ölçegi : ${item.size}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: Fonts.gilroyMedium)),
                                  const SizedBox(height: 6),
                                  Text("Reňki :   ${item.colorName}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: Fonts.gilroyMedium)),
                                  const SizedBox(height: 6),
                                  Padding(
                                    padding: EdgeInsets.zero,
                                    child: Row(
                                      children: [
                                        const Text("Geometriki şekli",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                fontFamily:
                                                    Fonts.gilroyMedium)),
                                        const SizedBox(width: 10),
                                        Chip(
                                          label: Text(
                                              item.product.figures.first.name,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily:
                                                      Fonts.gilroyMedium)),
                                          backgroundColor: const Color.fromARGB(
                                              255, 239, 244, 254),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                          padding: EdgeInsets.zero,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Mukdary: ${item.quantity}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: Fonts.gilroyMedium),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
