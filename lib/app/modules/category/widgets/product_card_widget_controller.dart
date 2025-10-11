import 'package:get/get.dart';
import 'package:haly/app/data/carpet_model.dart';
import 'package:haly/app/data/data_service.dart';

class ProductCardWidgetController extends GetxController {
  final Product product;
  final DataService _dataService = DataService();
  final Rx<Category?> category = Rx<Category?>(null);

  ProductCardWidgetController({required this.product});

  @override
  void onInit() {
    super.onInit();
    _fetchCategory();
  }

  void _fetchCategory() async {
    try {
      final carpetData = await _dataService.getCarpetData();
      category.value = carpetData.categories
          .firstWhereOrNull((c) => c.id == product.categoryId);
    } catch (e) {
      print('Error fetching category for product card: $e');
      category.value = null;
    }
  }
}
