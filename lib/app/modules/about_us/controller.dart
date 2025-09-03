import 'package:get/get.dart';
import 'package:haly/app/data/data_service.dart';
import 'package:haly/app/data/carpet_model.dart';

class AboutController extends GetxController {
  final DataService _dataService = Get.put(DataService());

  final about = Rx<About?>(null);

  final isLoading = true.obs;
  final hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAbout();
  }

  void fetchAbout() async {
    try {
      isLoading(true);
      hasError(false);

      final fetchedAboutData = await _dataService.getAbout();

      about.value = fetchedAboutData;
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }
}
