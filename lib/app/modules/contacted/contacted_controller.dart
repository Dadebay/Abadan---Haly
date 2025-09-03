import 'package:get/get.dart';
import 'package:haly/app/data/data_service.dart';
import 'package:haly/app/data/carpet_model.dart';

class ContactedController extends GetxController {
  final DataService _dataService = Get.put(DataService());
  final contacts = <Contact>[].obs;

  final isLoading = true.obs;
  final hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  void fetchContacts() async {
    try {
      isLoading(true);
      hasError(false);
      final contactList = await _dataService.getContacts();
      contacts.assignAll(contactList);
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }
}
