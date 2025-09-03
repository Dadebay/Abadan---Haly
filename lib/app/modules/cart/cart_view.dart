import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/cart/cart_controller.dart';
import 'package:haly/app/modules/cart/widgets/cart_bottom_bar.dart';
import 'package:haly/app/modules/cart/widgets/cart_item_card.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:haly/app/widgets/custom_app_bar_logo.dart';
import 'package:hugeicons/hugeicons.dart';

class CartView extends StatelessWidget {
  CartView({super.key});
  // CartController'ı Get.find() ile almak daha doğrudur,
  // çünkü muhtemelen başka bir yerden zaten başlatılmıştır.
  // Eğer ilk defa burada başlatılıyorsa Get.put() kalabilir.
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Obx(
        () => cartController.cartItems.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedShoppingBag02,
                        size: 100,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Sebediňiz boş',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            fontFamily: Fonts.gilroySemiBold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Harytlary gözläp, sebediňize goşup bilersiňiz.',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontFamily: Fonts.gilroySemiBold,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                itemCount: cartController.cartItems.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return CartItemCard(cartItem: item);
                },
              ),
      ),
      bottomNavigationBar: Obx(() => cartController.cartItems.isEmpty
          ? const SizedBox.shrink()
          : const CartBottomBar()),
    );
  }
}
