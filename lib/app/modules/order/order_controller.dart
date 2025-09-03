import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haly/app/data/order_model.dart';
import 'package:hugeicons/hugeicons.dart';

class OrderController extends GetxController {
  final RxList<Order> orders = <Order>[].obs;
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    List? storedOrders = _box.read('orders');
    if (storedOrders != null) {
      orders.assignAll(storedOrders.map((e) => Order.fromJson(e)).toList()
        ..sort((a, b) => b.orderDate.compareTo(a.orderDate)));
    }
    ever(orders, (_) => _saveOrdersToStorage());
  }

  void _saveOrdersToStorage() {
    _box.write('orders', orders.toList());
  }

  void addOrder(Order order) {
    orders.insert(0, order);
    Get.snackbar(
      'Tassyklama',
      'Tassyklama üstünlikli amala aşyryldy',
      icon: const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedTick01,
          size: 28,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.green.shade700,
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(15),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
