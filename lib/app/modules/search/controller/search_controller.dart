import 'package:get/get.dart';
import 'package:haly/app/data/carpet_model.dart';
import 'package:haly/app/data/data_service.dart';

class SearchController extends GetxController {
  final DataService _dataService = DataService();
  final RxList<Product> _products = <Product>[].obs;
  final RxList<Product> _filteredProducts = <Product>[].obs;
  final RxString _searchQuery = ''.obs;

  List<Product> get filteredProducts => _filteredProducts;
  String get searchQuery => _searchQuery.value;

  void fetchData() async {
    try {
      final carpetData = await _dataService.getCarpetData();
      _products.assignAll(carpetData.products);
      _filteredProducts.assignAll(carpetData.products.take(10).toList());
    } catch (e) {
      // print("Error fetching products: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void search(String query) {
    _searchQuery.value = query;
    if (query.isEmpty) {
      _filteredProducts.assignAll(_products.take(10).toList());
    } else {
      _filteredProducts.assignAll(_products.where((product) {
        final lowerCaseQuery = query.toLowerCase();
        return product.code.toLowerCase().contains(lowerCaseQuery) ||
            product.description!.toLowerCase().contains(lowerCaseQuery) ||
            product.figures.any((figure) => figure.colors
                .any((color) => color.name.toLowerCase().contains(lowerCaseQuery)));
      }));
    }
  }
}
