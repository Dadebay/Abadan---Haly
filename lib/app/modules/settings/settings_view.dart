import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/settings/widgets/bottom_button.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:haly/app/widgets/custom_detail_appbar.dart';
import 'package:haly/app/modules/settings/settings_controller.dart';
import 'package:hugeicons/hugeicons.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProductDetailAppbar(),
      bottomNavigationBar: BottomButton(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Domen sazlamasy",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: Fonts.gilroyBold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              shadowColor: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller.domainController,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: Fonts.gilroyRegular,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Täze domeniňizi giriziň',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: Fonts.gilroyRegular,
                        ),
                        prefixIcon: Icon(
                          HugeIcons.strokeRoundedGlobe02,
                          size: 26,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(thickness: 1, color: Color(0xFFE0E0E0)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Häzirki wagtda ulanylýan domen :',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: Fonts.gilroyBold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Obx(
                          () => Text(
                            controller.savedDomain.value,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: Fonts.gilroyRegular,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
