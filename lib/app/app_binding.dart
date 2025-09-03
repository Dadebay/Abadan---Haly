import 'package:get/get.dart';
import 'package:haly/app/modules/cart/cart_controller.dart';
import 'package:haly/app/modules/order/order_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController());
    Get.put<CartController>(CartController());
  }
}
