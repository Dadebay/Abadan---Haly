import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:haly/app/data/carpet_model.dart';
import 'package:haly/app/data/cart_item_model.dart';
import 'package:haly/app/data/data_service.dart';
import 'package:haly/app/modules/cart/cart_controller.dart';
import 'package:hugeicons/hugeicons.dart';

class ProductDetailController extends GetxController {
  final Product product;

  ProductDetailController({required this.product});

  final RxInt selectedIndex = 0.obs;
  final RxInt quantity = 1.obs;
  final RxInt selectedFigureIndex = 0.obs;
  final RxInt selectedSizeIndex = (-1).obs;
  final RxInt selectedEdgeIndex = 0.obs;

  final RxString selectedColorName = ''.obs;
  final RxString selectedColorHex = ''.obs;
  final RxString selectedColorImage = ''.obs;
  final RxString note = ''.obs;

  late TextEditingController widthController;
  late TextEditingController lengthController;
  late TextEditingController noteController;
  late PageController pageController;

  late final CartController _cartController;
  final DataService _dataService = DataService();
  final RxList<Product> filteredProducts = <Product>[].obs;
  final RxList<Product> filteredProductskopsatylan = <Product>[].obs;
  final RxList<Edge> edges = <Edge>[].obs;
  var settings = Rx<Settings?>(null);
  Rx<CarpetData?> _carpetData = Rx<CarpetData?>(null);
  final widthFocusNode = FocusNode();
  final lengthFocusNode = FocusNode();
  var widthErrorText = Rx<String?>(null);
  var heightErrorText = Rx<String?>(null);
  @override
  void onInit() {
    super.onInit();
    widthController = TextEditingController();
    lengthController = TextEditingController();
    noteController = TextEditingController();
    pageController = PageController(initialPage: selectedIndex.value);
    _cartController = Get.find<CartController>();

    if (product.figures.isNotEmpty && product.figures.first.colors.isNotEmpty) {
      selectedColorName.value = product.figures.first.colors.first.name;
      selectedColorHex.value = product.figures.first.colors.first.hexCode;
      selectedColorImage.value = product.figures.first.colors.first.image;
    } else if (product.figures.isNotEmpty) {
      selectedColorName.value = '';
      selectedColorHex.value = '';
      selectedColorImage.value = product.figures.first.image;
    }
    _loadFilteredProducts();
    loadFilteredProductskopsatylan();
    _loadSettingsAndAddListeners();
    _loadEdges();
  }

  void _loadEdges() async {
    edges.value = await _dataService.getEdges();
  }

  void _loadFilteredProducts() async {
    final carpetData = await _dataService.getCarpetData();
    _carpetData.value = carpetData;
    final allProducts = carpetData.products;
    filteredProducts.value = allProducts
        .where((p) =>
            carpetData.categories
                .firstWhere((c) => c.id == p.categoryId)
                .name ==
            carpetData.categories
                .firstWhere((c) => c.id == product.categoryId)
                .name &&
            p.code != product.code)
        .toList();
  }

  void loadFilteredProductskopsatylan() async {
    final carpetData = await _dataService.getCarpetData();
    _carpetData.value = carpetData;
    final allProducts = carpetData.products;
    final category = carpetData.categories
        .firstWhereOrNull((c) => c.id == product.categoryId);

    if (category != null) {
      final topSellingIds = category.topSellingProductsIds;

      if (topSellingIds != null && topSellingIds.isNotEmpty) {
        filteredProductskopsatylan.value =
            allProducts.where((p) => topSellingIds.contains(p.id)).toList();
      } else {
        filteredProductskopsatylan.value = [];
      }
    } else {
      filteredProductskopsatylan.value = [];
    }
  }

  void _loadSettingsAndAddListeners() async {
    try {
      settings.value = await _dataService.getSettings();
    } catch (e) {
      print("Ayarları yüklerken hata oluştu: $e");
    }

    widthFocusNode.addListener(() {
      if (!widthFocusNode.hasFocus) {
        validateWidth(widthController.text);
      }
    });

    lengthFocusNode.addListener(() {
      if (!lengthFocusNode.hasFocus) {
        validateHeight(lengthController.text);
      }
    });
  }

  bool canAddToCart() {
    final w = widthController.text;
    final l = lengthController.text;

    if ((w.isNotEmpty && l.isEmpty) || (w.isEmpty && l.isNotEmpty)) {
      Get.snackbar(
        'Ýalňyşlyk',
        'Halyň ini we uzynlygyny doly giriziň',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (w.isNotEmpty && l.isNotEmpty) {
      final isWidthValid = validateWidth(w);
      final isHeightValid = validateHeight(l);
      if (!isWidthValid || !isHeightValid) {
        return false;
      }
    }

    return true;
  }

  bool validateWidth(String value) {
    widthErrorText.value = null;
    final min = settings.value?.sizeRange.width.min;
    final max = settings.value?.sizeRange.width.max;

    if (value.isEmpty) return true;

    final intValue = int.tryParse(value);
    if (intValue == null) {
      widthErrorText.value = "Diňe san giriziň";
      return false;
    }
    if (min != null && intValue < min) {
      widthErrorText.value = "Ini $min sm-den az bolmaly däl";
      return false;
    }
    if (max != null && intValue > max) {
      widthErrorText.value = "Ini $max sm-den köp bolmaly däl";
      return false;
    }
    return true;
  }

  bool validateHeight(String value) {
    heightErrorText.value = null;
    final min = settings.value?.sizeRange.height.min;
    final max = settings.value?.sizeRange.height.max;

    if (value.isEmpty) return true;

    final intValue = int.tryParse(value);
    if (intValue == null) {
      heightErrorText.value = "Diňe san giriziň";
      return false;
    }
    if (min != null && intValue < min) {
      heightErrorText.value = "Uzynlyk $min sm-den az bolmaly däl";
      return false;
    }
    if (max != null && intValue > max) {
      heightErrorText.value = "Uzynlyk $max sm-den köp bolmaly däl";
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    widthController.dispose();
    lengthController.dispose();
    noteController.dispose();
    pageController.dispose();
    widthFocusNode.dispose();
    lengthFocusNode.dispose();
    super.onClose();
  }

  void updatePageIndex(int index) {
    selectedIndex.value = index;
    if (pageController.hasClients) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    // When the page view changes, update the selected color details
    final currentFigure = product.figures[selectedFigureIndex.value];
    if (index < currentFigure.colors.length) {
      final color = currentFigure.colors[index];
      selectedColorName.value = color.name;
      selectedColorHex.value = color.hexCode;
      selectedColorImage.value = color.image;
    }
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void selectFigure(int index) {
    selectedFigureIndex.value = index;
    selectedSizeIndex.value = -1;

    if (product.figures.isNotEmpty &&
        product.figures[index].colors.isNotEmpty) {
      selectedColorName.value = product.figures[index].colors.first.name;
      selectedColorHex.value = product.figures[index].colors.first.hexCode;
      selectedColorImage.value = product.figures[index].colors.first.image;
    } else {
      selectedColorName.value = '';
      selectedColorHex.value = '';
      selectedColorImage.value = product.figures[index].image;
    }
  }

  void selectSize(int index) {
    selectedSizeIndex.value = index;
    final selectedFigure = product.figures[selectedFigureIndex.value];
    if (index >= 0 && index < selectedFigure.sizes.length) {
      final size = selectedFigure.sizes[index];
      widthController.text = size.width.toString();
      lengthController.text = size.height.toString();
    }
  }

  void selectEdge(int index) {
    selectedEdgeIndex.value = index;
  }

  void selectColor(CarpetColor color) {
    selectedColorName.value = color.name;
    selectedColorHex.value = color.hexCode;
    selectedColorImage.value = color.image;

    final currentFigureColors =
        product.figures[selectedFigureIndex.value].colors;
    final colorIndex = currentFigureColors.indexOf(color);
    if (colorIndex != -1 && pageController.hasClients) {
      pageController.jumpToPage(colorIndex);
    }
  }

  void addProductToCart() {
    // Geometrik şekil ve renk seçimi kontrolleri aynı kalıyor...
    if (selectedFigureIndex.value < 0 ||
        selectedFigureIndex.value >= product.figures.length) {
      // ... hata mesajı
      return;
    }
    final selectedFigure = product.figures[selectedFigureIndex.value];

    CarpetColor? selectedColor;
    if (selectedFigure.colors.isNotEmpty) {
      // ... renk seçimi kontrolü ...
      if (selectedColorHex.value.isEmpty) {
        /*...*/ return;
      }
      selectedColor = selectedFigure.colors
          .firstWhereOrNull((c) => c.hexCode == selectedColorHex.value);
      if (selectedColor == null) {
        /*...*/ return;
      }
    }

    // --- ÖLÇÜ KONTROLÜNÜ BURADA YAPACAĞIZ ---
    Size? selectedSize;
    final customWidth = double.tryParse(widthController.text);
    final customLength = double.tryParse(lengthController.text);

    if (customWidth != null && customLength != null) {
      // Özel ölçü girilmişse onu kullan
      selectedSize = Size(
          id: 0,
          width: customWidth.toInt(),
          height: customLength.toInt(),
          measurementUnit: 'sm');
    } else if (selectedSizeIndex.value != -1 &&
        selectedSizeIndex.value < selectedFigure.sizes.length) {
      // Standart ölçü seçilmişse onu kullan
      selectedSize = selectedFigure.sizes[selectedSizeIndex.value];
    }

    // YENİ KONTROL: Eğer ne özel ölçü girilmiş ne de standart ölçü seçilmişse HATA VER.
    if (selectedSize == null) {
      Get.snackbar(
        'Ýalňyşlyk',
        "Standart ölçegi saýlaň ýa-da ölçegleri özüňiz giriziň!", // Standart ölçü seçin ya da ölçüleri kendiniz girin!
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
      return; // İşlemi durdur
    }

    final selectedEdge = edges[selectedEdgeIndex.value];

    // Hata yoksa, sepet öğesini oluştur ve ekle
    final cartItem = CartItem(
      product: product,
      quantity: quantity.value,
      colorName: selectedColor?.name ?? '',
      size:
          '${selectedSize.width}x${selectedSize.height} ${selectedSize.measurementUnit}',
      imageUrl: selectedColorImage.value,
      edge: selectedEdge.name,
      note: note.value,
    );

    _cartController.addToCart(cartItem);
  }

  CartItem? getCartItem() {
    final selectedFigure = product.figures[selectedFigureIndex.value];
    final selectedColor = selectedFigure.colors
        .firstWhereOrNull((c) => c.hexCode == selectedColorHex.value);

    Size? selectedSize;
    final customWidth = double.tryParse(widthController.text);
    final customLength = double.tryParse(lengthController.text);

    if (customWidth != null && customLength != null) {
      selectedSize = Size(
          id: 0,
          width: customWidth.toInt(),
          height: customLength.toInt(),
          measurementUnit: 'sm');
    } else if (selectedSizeIndex.value != -1 &&
        selectedSizeIndex.value < selectedFigure.sizes.length) {
      selectedSize = selectedFigure.sizes[selectedSizeIndex.value];
    }

    // Eğer ölçü bulunamadıysa null döndür, bu diyalogun gösterilmemesini tetikleyebilir.
    if (selectedSize == null) return null;
    final selectedEdge = edges[selectedEdgeIndex.value];

    return CartItem(
      product: product,
      quantity: quantity.value,
      colorName: selectedColor?.name ?? '',
      size:
          '${selectedSize.width}x${selectedSize.height} ${selectedSize.measurementUnit}',
      imageUrl: selectedColorImage.value,
      edge: selectedEdge.name,
      note: note.value,
    );
  }

  String getCategoryName(int categoryId) {
    if (_carpetData.value == null) return 'Unknown';
    final category = _carpetData.value!.categories
        .firstWhereOrNull((c) => c.id == categoryId);
    return category?.name ?? 'Unknown';
  }

  Category? getCategory(int categoryId) {
    if (_carpetData.value == null) return null;
    return _carpetData.value!.categories
        .firstWhereOrNull((c) => c.id == categoryId);
  }
}
