import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/bottomnavbar/bottom_nav_bar_controller.dart';
import 'package:haly/app/modules/onboarding/views/splash_view.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haly/app/app_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final BottomNavBarController controller = Get.put(BottomNavBarController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      theme: ThemeData(
        fontFamily: Fonts.gilroyRegular,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      title: 'Abadan Haly',
      home: const SplashScreen(),
    );
  }
}
