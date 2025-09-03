import 'package:get/get.dart';
import 'package:haly/app/data/carpet_model.dart';
import 'package:haly/app/data/data_service.dart';

class OrderDetailViewController extends GetxController {
  final DataService _dataService = DataService();
  Rx<CarpetData?> carpetData = Rx<CarpetData?>(null);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchCarpetData();
  }

  void _fetchCarpetData() async {
    try {
      isLoading.value = true;
      carpetData.value = await _dataService.getCarpetData();
    } catch (e) {
      print('Error fetching carpet data in OrderDetailViewController: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String getCategoryName(int categoryId) {
    if (carpetData.value == null) return 'Unknown';
    final category = carpetData.value!.categories
        .firstWhereOrNull((c) => c.id == categoryId);
    return category?.name ?? 'Unknown';
  }
}
