import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/order/order_controller.dart';
import 'package:haly/app/modules/order/order_detail_view.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:haly/app/theme/theme/theme_colors.dart';
import 'package:haly/app/widgets/custom_app_bar_logo.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.put(OrderController());

    return Scaffold(
      appBar: customAppBar(),
      body: Obx(
        () => orderController.orders.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedDocumentAttachment,
                        size: 100,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Tassyklanan sargyt ýok',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: Fonts.gilroySemiBold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sargyt edeniňizden soň, bu ýerde görüp bilersiňiz.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade400,
                          fontFamily: Fonts.gilroyRegular,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : ListView.separated(
                itemCount: orderController.orders.length,
                padding: const EdgeInsets.all(16),
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final order = orderController.orders[index];
                  return ListTile(
                    leading: const CircleAvatar(
                      radius: 24,
                      backgroundColor: Color.fromARGB(255, 245, 245, 245),
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedDocumentAttachment,
                        size: 24,
                        color: AppColors.green,
                      ),
                    ),
                    title: Text(
                      'Order ID (${order.id})',
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: Fonts.gilroySemiBold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text(
                      DateFormat('dd.MM.yyyy').format(order.orderDate),
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: Fonts.gilroyRegular,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      Get.to(() => OrderDetailView(order: order));
                    },
                  );
                },
              ),
      ),
    );
  }
}
