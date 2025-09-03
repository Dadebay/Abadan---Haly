import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haly/app/theme/theme/app_theme.dart';

class OrderItemCard extends StatelessWidget {
  final String orderId;
  final String orderDate;

  const OrderItemCard({
    super.key,
    required this.orderId,
    required this.orderDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: const Color.fromARGB(255, 245, 245, 245)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.sargutlar,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              orderId,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: Fonts.gilroySemiBold),
            ),
          ),
          Text(orderDate,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
