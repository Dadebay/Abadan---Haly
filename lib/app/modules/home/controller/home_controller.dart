import 'package:get/get.dart';
import 'package:haly/app/data/carpet_model.dart';
import 'package:haly/app/data/data_service.dart';


class HomeController extends GetxController {
  final DataService dataService = DataService();
  var carpetData = Rxn<CarpetData>();
  var isLoading = true.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCarpetData();
  }

  void fetchCarpetData() async {
    try {
      isLoading(true);
      hasError(false);
      carpetData.value = await dataService.getCarpetData();
    } catch (e) {
      hasError(true);
      // print("Error fetching carpet data: $e");
    } finally {
      isLoading(false);
    }
  }
}