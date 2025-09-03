import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/data/cart_item_model.dart';
import 'package:haly/app/modules/cart/cart_controller.dart';
import 'package:haly/app/modules/cart/widgets/cart_item_card_controller.dart';
import 'package:haly/app/modules/cart/widgets/quantity_button.dart';
import 'package:haly/app/theme/theme/app_theme.dart';

class CartItemCard extends GetView<CartItemCardController> {
  final CartItem cartItem;

  CartItemCard({Key? key, required this.cartItem}) : super(key: key) {
    Get.put(CartItemCardController(cartItem: cartItem),
        tag: cartItem.product.id.toString());
  }
  final CartController cartController = Get.find<CartController>();
  @override
  String? get tag => cartItem.product.id.toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 394,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1),
                child: Image.file(
                  File(cartItem.imageUrl),
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
                    Obx(() => Text(controller.categoryName.value,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            fontFamily: Fonts.gilroySemiBold))),
                    const SizedBox(height: 6),
                    Text("Kody: ${cartItem.product.code}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: Fonts.gilroyMedium)),
                    const SizedBox(height: 6),
                    Text("Kenary: ${cartItem.edge}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: Fonts.gilroyMedium)),
                    const SizedBox(height: 6),
                    Text("Ölçegi : ${cartItem.size}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: Fonts.gilroyMedium)),
                    const SizedBox(height: 6),
                    Text("Reňki :   ${cartItem.colorName}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: Fonts.gilroyMedium)),
                    const SizedBox(height: 6),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Geometriki şekili",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: Fonts.gilroyMedium,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Chip(
                            label: Text(
                              cartItem.product.figures.first.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: Fonts.gilroyMedium,
                              ),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 239, 244, 254),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        QuantityButton(
                          Icons.remove,
                          onTap: () =>
                              cartController.decrementQuantity(cartItem),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 32,
                          child: Text(
                            '${cartItem.quantity}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              fontFamily: Fonts.gilroySemiBold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        QuantityButton(
                          Icons.add,
                          isAdd: true,
                          onTap: () =>
                              cartController.incrementQuantity(cartItem),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => cartController.removeFromCart(cartItem),
            ),
          )
        ],
      ),
    );
  }
}
