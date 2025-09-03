import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hugeicons/hugeicons.dart';

class SettingsController extends GetxController {
  final _box = GetStorage();
  final domainController = TextEditingController();
  final RxString savedDomain = ''.obs;

  @override
  void onInit() {
    super.onInit();
    savedDomain.value = _box.read('domain') ?? 'https://carpet.sada-devs.com';
    domainController.text = savedDomain.value;
  }

  void saveDomain() {
    final newDomain = domainController.text;
    if (newDomain.isNotEmpty) {
      _box.write('domain', newDomain);
      savedDomain.value = newDomain;
      Get.snackbar(
        'Üstünlikli',
        "Domen ýatda saklanyldy we üýtgedildi!",
        icon: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedCheckList,
            size: 28,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(15),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    } else {
      Get.snackbar(
        'Ýalňyşlyk',
        "Ýazgy boş bolup bilmez!",
        icon: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedAlertCircle,
            size: 28,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(15),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }
}
