import 'package:get/get.dart';
import 'package:haly/app/data/carpet_model.dart';
import 'package:haly/app/data/data_service.dart';

class ProductCardWidgetController extends GetxController {
  final Product product;
  final DataService _dataService = DataService();
  final RxString categoryName = ''.obs;

  ProductCardWidgetController({required this.product});

  @override
  void onInit() {
    super.onInit();
    _fetchCategoryName();
  }

  void _fetchCategoryName() async {
    try {
      final carpetData = await _dataService.getCarpetData();
      final category = carpetData.categories
          .firstWhereOrNull((c) => c.id == product.categoryId);
      if (category != null) {
        categoryName.value = category.name;
      }
    } catch (e) {
      print('Error fetching category name for product card: $e');
      categoryName.value = 'Unknown Category'; // Fallback
    }
  }
}
