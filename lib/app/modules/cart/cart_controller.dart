import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haly/app/data/cart_item_model.dart';
import 'package:haly/app/data/order_model.dart';
import 'package:haly/app/modules/order/order_controller.dart';
import 'package:hugeicons/hugeicons.dart';

class CartController extends GetxController {
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  final OrderController _orderController = Get.find<OrderController>();
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    List? storedCart = _box.read('cartItems');
    if (storedCart != null) {
      cartItems.assignAll(storedCart.map((e) => CartItem.fromJson(e)).toList());
    }
    ever(cartItems, (_) => _saveCartToStorage());
  }

  void _saveCartToStorage() {
    _box.write('cartItems', cartItems.toList());
  }

  void addToCart(CartItem item) {
    final existingItemIndex = cartItems.indexWhere(
      (cartItem) =>
          cartItem.product.code == item.product.code &&
          cartItem.colorName == item.colorName &&
          cartItem.size == item.size,
    );

    if (existingItemIndex != -1) {
      cartItems[existingItemIndex].quantity += item.quantity;
      cartItems.refresh();
    } else {
      cartItems.add(item);
    }
    Get.snackbar(
      'Sebet',
      'Haryt sebede goşuldy',
      icon: const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedShoppingBagAdd,
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

  void incrementQuantity(CartItem item) {
    item.quantity++;
    cartItems.refresh();
  }

  void decrementQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      cartItems.refresh();
    } else {
      removeFromCart(item);
    }
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
    Get.snackbar(
      'Sebet',
      'Haryt Sebetden çykaryldy',
      icon: const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedTaskRemove01,
          size: 28,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.orange.shade700,
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(15),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  void placeOrder() {
    if (cartItems.isEmpty) {
      Get.snackbar(
        'Ýalňyşlyk',
        'Sebediňiz boş, sargyt döredip bolmaýar!',
        icon: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedAlertCircle,
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

    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      orderDate: DateTime.now(),
      items: List<CartItem>.from(cartItems),
    );

    _orderController.addOrder(newOrder);
    cartItems.clear();
    // Get.find<BottomNavBarController>().changeIndex(3);
  }
}
