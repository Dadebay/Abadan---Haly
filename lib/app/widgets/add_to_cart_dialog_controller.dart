import 'package:get/get.dart';
import 'package:haly/app/data/carpet_model.dart';
import 'package:haly/app/data/cart_item_model.dart';
import 'package:haly/app/data/data_service.dart';

class AddToCartDialogController extends GetxController {
  final CartItem cartItem;
  final DataService _dataService = DataService();
  final RxString categoryName = ''.obs;

  AddToCartDialogController({required this.cartItem});

  @override
  void onInit() {
    super.onInit();
    _fetchCategoryName();
  }

  void _fetchCategoryName() async {
    try {
      final carpetData = await _dataService.getCarpetData();
      final category = carpetData.categories
          .firstWhereOrNull((c) => c.id == cartItem.product.categoryId);
      if (category != null) {
        categoryName.value = category.name;
      }
    } catch (e) {
      print('Error fetching category name for add to cart dialog: $e');
      categoryName.value = 'Unknown Category'; // Fallback
    }
  }
}
