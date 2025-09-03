import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  final IconData icon;
  final bool isAdd;
  final VoidCallback? onTap;

  const QuantityButton(this.icon, {super.key, this.isAdd = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: isAdd ? Colors.green : Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: isAdd ? Colors.white : Colors.black, size: 18),
      ),
    );
  }
}
