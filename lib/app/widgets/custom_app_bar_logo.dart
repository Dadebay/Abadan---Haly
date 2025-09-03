import 'package:flutter/material.dart';
import 'package:haly/app/theme/theme/app_theme.dart';

PreferredSizeWidget customAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(120),
    child: SafeArea(
      child: Container(
        height: 120,
        color: Colors.white,
        alignment: Alignment.center,
        child: Image.asset(
          Assets.logo,
          height: 84,
          width: 136,
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}
