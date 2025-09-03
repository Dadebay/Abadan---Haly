import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haly/app/modules/bottomnavbar/bottom_nav_bar_controller.dart';
import 'package:haly/app/modules/profile/controller/profile_controller.dart';
import 'package:haly/app/modules/profile/widgets/profile_option_card.dart';
import 'package:haly/app/modules/settings/settings_view.dart';
import 'package:haly/app/widgets/custom_app_bar_logo.dart';
import 'package:hugeicons/hugeicons.dart';

class ProfileView extends StatelessWidget {
  final List<Map<String, Object>> options = [
    {"title": "Sazlamalar", "icon": HugeIcons.strokeRoundedSetting06},
    {
      "title": "Tassyklanan harytlar",
      "icon": HugeIcons.strokeRoundedDocumentAttachment
    },
    {
      "title": "Maglumatlary ýükle",
      "icon": HugeIcons.strokeRoundedDownloadCircle02
    },
    {
      "title": "Maglumatlary iber",
      "icon": HugeIcons.strokeRoundedUploadCircle02
    },
  ];

  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: customAppBar(),
      body: ListView.separated(
        padding: const EdgeInsets.all(25),
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = options[index];
          return GestureDetector(
            onTap: () async {
              if (item["title"] == "Sazlamalar") {
                Get.to(() => SettingsView());
              } else if (item["title"] == "Tassyklanan harytlar") {
                Get.find<BottomNavBarController>().changeIndex(3);
              } else if (item["title"] == "Maglumatlary ýükle") {
                await controller.importData();
              } else if (item["title"] == "Maglumatlary iber") {
                await controller.uploadOrders();
              }
            },
            child: ProfileOptionCard(
              title: item["title"]! as String,
              iconPath: item["icon"]! as IconData,
              isLoading: false.obs,
            ),
          );
        },
      ),
    );
  }
}
