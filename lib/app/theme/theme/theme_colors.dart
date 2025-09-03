import 'package:flutter/material.dart';
import 'package:haly/app/modules/home/view/home_view.dart';
import 'package:haly/app/modules/order/order_view.dart';
import 'package:haly/app/modules/profile/profile_view.dart';
import 'package:haly/app/modules/search/search_view.dart';

import '../../modules/cart/cart_view.dart';

class AppColors {
  static const Color green = Color.fromRGBO(0, 147, 61, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color black = Color.fromRGBO(36, 35, 35, 1);
  static const Color background = Color.fromARGB(255, 226, 231, 253);
  static const Color success = Color.fromARGB(255, 12, 147, 19);
  static const Color grey = Color.fromRGBO(102, 102, 102, 1);
}

final List<Widget> screens = [
  const HomeView(),
  const SearchView(),
  CartView(),
  const OrderView(),
  ProfileView(),
];
