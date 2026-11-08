import 'package:get/get.dart';
import 'package:haly/app/data/carpet_model.dart';
import 'package:haly/app/data/data_service.dart';

class SearchController extends GetxController {
  final DataService _dataService = DataService();
  final RxList<Product> _products = <Product>[].obs;
  final RxList<Category> _categories = <Category>[].obs;
  final RxList<Product> _filteredProducts = <Product>[].obs;
  final RxString _searchQuery = ''.obs;

  List<Product> get filteredProducts => _filteredProducts;
  String get searchQuery => _searchQuery.value;

  void fetchData() async {
    try {
      final carpetData = await _dataService.getCarpetData();
      _products.assignAll(carpetData.products);
      _categories.assignAll(carpetData.categories);
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
      return;
    }

    final lowerCaseQuery = query.toLowerCase();
    final List<Product> results = [];

    for (final product in _products) {
      final category =
          _categories.firstWhereOrNull((cat) => cat.id == product.categoryId);
      final subcategory = category?.subcategories
          .firstWhereOrNull((sub) => sub.id == product.subCategoryId);

      final bool isCategoryMatch =
          category?.name.toLowerCase().contains(lowerCaseQuery) ?? false;
      final bool isSubcategoryMatch =
          subcategory?.name.toLowerCase().contains(lowerCaseQuery) ?? false;
      final bool isCodeMatch =
          product.code.toLowerCase().contains(lowerCaseQuery);
      final bool isDescriptionMatch =
          product.description?.toLowerCase().contains(lowerCaseQuery) ?? false;
      final bool isColorMatch = product.figures.any((figure) => figure.colors
          .any((color) => color.name.toLowerCase().contains(lowerCaseQuery)));

      if (isCodeMatch ||
          isDescriptionMatch ||
          isColorMatch ||
          isCategoryMatch ||
          isSubcategoryMatch) {
        results.add(product);
      }
    }
    _filteredProducts.assignAll(results);
  }
}
