import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/data/cart_item_model.dart';
import 'package:haly/app/theme/theme/theme_colors.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:haly/app/widgets/add_to_cart_dialog_controller.dart';

class AddToCartDialog extends GetView<AddToCartDialogController> {
  final CartItem cartItem;
  final VoidCallback onConfirm;

  AddToCartDialog(
      {super.key, required this.cartItem, required this.onConfirm}) {
    Get.put(AddToCartDialogController(cartItem: cartItem),
        tag: cartItem.product.id.toString());
  }

  @override
  String? get tag => cartItem.product.id.toString();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20.0,
            spreadRadius: 5.0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildProductInfo(),
                  const SizedBox(height: 24.0),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Text(
            'Tassyklama',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              fontFamily: Fonts.gilroyBold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Obx(() => Text(
                  '"${controller.categoryName.value}" harydyny sebede goşmak isleýärsiňizmi?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: Fonts.gilroySemiBold,
                    color: Theme.of(context).textTheme.titleSmall?.color,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.file(
            File(cartItem.imageUrl),
            width: 100,
            height: 120,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 40.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildInfoRow(
                  Icons.shopping_bag_outlined, 'Mukdary: ${cartItem.quantity}'),
              const SizedBox(height: 12.0),
              _buildInfoRow(
                  Icons.aspect_ratio_outlined, 'Kenary: ${cartItem.edge}'),
              const SizedBox(height: 12.0),
              _buildInfoRow(
                  Icons.color_lens_outlined, 'Reňki: ${cartItem.colorName}'),
              const SizedBox(height: 12.0),
              _buildInfoRow(
                  Icons.aspect_ratio_outlined, 'Ölçegi: ${cartItem.size}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.grey, size: 20),
        const SizedBox(width: 8.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            fontFamily: Fonts.gilroyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              side: BorderSide(color: AppColors.grey.withOpacity(0.5)),
            ),
            child: const Text(
              'Ýok',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 16,
                fontFamily: Fonts.gilroySemiBold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: AppColors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 5, // Düğmeye derinlik hissi verir
              shadowColor: AppColors.green.withOpacity(0.4),
            ),
            child: const Text(
              'Hawa',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: Fonts.gilroySemiBold,
              ),
            ),
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
