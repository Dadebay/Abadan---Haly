import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:haly/app/data/carpet_model.dart';
import 'package:haly/app/modules/category/widgets/product_card_widget.dart';
import 'package:haly/app/modules/produts/controllers/product_detail_controller.dart';
import 'package:haly/app/modules/produts/view/product_image_screen.dart';
import 'package:haly/app/widgets/add_to_cart_dialog.dart';
import 'package:haly/app/widgets/custom_detail_appbar.dart';
import 'package:haly/app/theme/theme/app_theme.dart';
import 'package:haly/app/theme/theme/theme_colors.dart';

class ProductDetailView extends StatefulWidget {
  final Product product;
  final Category? category;
  const ProductDetailView({super.key, required this.product, this.category});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late ProductDetailController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(
      ProductDetailController(
          product: widget.product, category: widget.category),
      tag: widget.product.code, // Unique tag for each product
    );
  }

  @override
  void dispose() {
    // Clean up the controller to prevent memory leaks and state issues
    Get.delete<ProductDetailController>(tag: widget.product.code);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProductDetailAppbar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: bottomNavBar(controller, context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => Container(
                color: const Color.fromARGB(255, 246, 246, 248),
                height: Get.height * 0.4,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.updatePageIndex(index);
                  },
                  itemCount: widget
                      .product
                      .figures[controller.selectedFigureIndex.value]
                      .colors
                      .length,
                  itemBuilder: (context, index) {
                    final color = widget
                        .product
                        .figures[controller.selectedFigureIndex.value]
                        .colors[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageZoomScreen(
                              imagePath: color.image,
                              productCode: widget.product.code,
                              productName:
                                  controller.category.value?.name ?? '',
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          File(color.image),
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () {
                if (widget.product.figures[controller.selectedFigureIndex.value]
                        .colors.length >
                    1) {
                  return SizedBox(
                    height: 102,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget
                          .product
                          .figures[controller.selectedFigureIndex.value]
                          .colors
                          .length,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemBuilder: (context, index) {
                        final color = widget
                            .product
                            .figures[controller.selectedFigureIndex.value]
                            .colors[index];
                        return GestureDetector(
                          onTap: () {
                            controller.selectColor(color);
                            controller.pageController.jumpToPage(index);
                          },
                          child: Obx(
                            () => Container(
                              width: 102,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: controller.selectedColorHex.value ==
                                          color.hexCode
                                      ? const Color.fromARGB(255, 102, 102, 102)
                                      : const Color.fromARGB(
                                          255, 231, 231, 231),
                                  width: controller.selectedColorHex.value ==
                                          color.hexCode
                                      ? 2.5
                                      : 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6.0),
                                child: Image.file(
                                  File(color.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 245, 245, 245),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.category?.name ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: Fonts.gilroySemiBold,
                            color: Color.fromARGB(255, 102, 102, 102),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.chevron_right,
                            color: Color.fromARGB(255, 245, 245, 245)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 245, 245, 245),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF4CAF50)),
                        ),
                        child: Obx(() => Text(
                              controller.subcategory.value?.name ?? '',
                              style: const TextStyle(
                                color: AppColors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: Fonts.gilroySemiBold,
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.category?.name ?? '',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                fontFamily: Fonts.gilroySemiBold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.product.code,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(255, 110, 110, 112),
                                fontFamily: Fonts.gilroyBold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Obx(() => Text(
                                  controller.selectedColorName.value.isNotEmpty
                                      ? controller.selectedColorName.value
                                      : (widget
                                              .product
                                              .figures[controller
                                                  .selectedFigureIndex.value]
                                              .colors
                                              .isNotEmpty
                                          ? widget
                                              .product
                                              .figures[controller
                                                  .selectedFigureIndex.value]
                                              .colors
                                              .first
                                              .name
                                          : ''),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Color.fromARGB(255, 110, 110, 112),
                                    fontFamily: Fonts.gilroyBold,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Reňkler:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: Fonts.gilroySemiBold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Obx(
                              () => Wrap(
                                spacing: 10.0,
                                runSpacing: 10.0,
                                children: widget
                                    .product
                                    .figures[
                                        controller.selectedFigureIndex.value]
                                    .colors
                                    .map((color) => GestureDetector(
                                          onTap: () {
                                            controller.selectColor(color);
                                          },
                                          child: Obx(() {
                                            return Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Color(int.parse(color
                                                    .hexCode
                                                    .replaceAll('#', '0xFF'))),
                                                borderRadius:
                                                    BorderRadius.circular(54),
                                                border: Border.all(
                                                  color: controller
                                                              .selectedColorHex
                                                              .value ==
                                                          color.hexCode
                                                      ? AppColors.green
                                                      : Colors.transparent,
                                                  width: controller
                                                              .selectedColorHex
                                                              .value ==
                                                          color.hexCode
                                                      ? 4.0
                                                      : 0,
                                                ),
                                              ),
                                            );
                                          }),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.decrementQuantity();
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color.fromARGB(255, 224, 224, 224),
                                width: 1),
                          ),
                          child:
                              const Icon(Icons.remove, color: AppColors.grey),
                        ),
                      ),
                      Obx(
                        () => SizedBox(
                          width: 60,
                          child: Text(
                            '${controller.quantity.value}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: Fonts.gilroySemiBold,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.incrementQuantity();
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.add, color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Halynyň kenary',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: Fonts.gilroySemiBold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: controller.edges.asMap().entries.map((entry) {
                        int index = entry.key;
                        Edge edge = entry.value;
                        return GestureDetector(
                          onTap: () {
                            controller.selectEdge(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: controller.selectedEdgeIndex.value == index
                                  ? AppColors.green
                                  : const Color.fromRGBO(239, 244, 254, 1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              edge.name,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: Fonts.gilroySemiBold,
                                  fontWeight: FontWeight.w600,
                                  color: controller.selectedEdgeIndex.value ==
                                          index
                                      ? AppColors.white
                                      : AppColors.black),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Geometrik şekli',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: Fonts.gilroySemiBold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children:
                          widget.product.figures.asMap().entries.map((entry) {
                        int index = entry.key;
                        Figure figure = entry.value;
                        return GestureDetector(
                          onTap: () {
                            controller.selectFigure(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedFigureIndex.value == index
                                      ? AppColors.green
                                      : const Color.fromRGBO(239, 244, 254, 1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              figure.name,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: Fonts.gilroySemiBold,
                                  fontWeight: FontWeight.w600,
                                  color: controller.selectedFigureIndex.value ==
                                          index
                                      ? AppColors.white
                                      : AppColors.black),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Standart ölçegler',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: Fonts.gilroySemiBold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(
                    () => Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: widget.product
                          .figures[controller.selectedFigureIndex.value].sizes
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        Size size = entry.value;
                        return GestureDetector(
                          onTap: () {
                            controller.selectSize(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: controller.selectedSizeIndex.value == index
                                  ? AppColors.green
                                  : const Color.fromRGBO(239, 244, 254, 1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              '${size.width}x${size.height} ${size.measurementUnit}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: Fonts.gilroySemiBold,
                                  fontWeight: FontWeight.w600,
                                  color: controller.selectedSizeIndex.value ==
                                          index
                                      ? AppColors.white
                                      : AppColors.black),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 247, 247),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sargamak isleýän halyňyzyň öçlegini elde hem girizip bilersiňiz!',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: Fonts.gilroySemiBold,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 0, 147, 61),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Ölçegi elde girizmek',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: Fonts.gilroySemiBold,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 39, 39, 39),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          border: Border.all(
                                              color: const Color(0xFFE0E0E0)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Obx(() => TextField(
                                              controller:
                                                  controller.widthController,
                                              focusNode:
                                                  controller.widthFocusNode,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) => controller
                                                  .validateWidth(value),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                hintText: 'Ini (sm)',
                                                suffixText: 'sm',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: controller
                                                                .widthErrorText
                                                                .value ==
                                                            null
                                                        ? const Color(
                                                            0xFFE0E0E0)
                                                        : Colors.red,
                                                    width: controller
                                                                .widthErrorText
                                                                .value ==
                                                            null
                                                        ? 1.0
                                                        : 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: controller
                                                                .widthErrorText
                                                                .value ==
                                                            null
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Colors.red,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                suffixStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:
                                                        Fonts.gilroySemiBold,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                hintStyle: const TextStyle(
                                                    color: Color(0xFF9E9E9E)),
                                              ),
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            )),
                                      ),
                                      Obx(() {
                                        if (controller.widthErrorText.value !=
                                            null) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0, left: 2.0),
                                            child: Text(
                                              controller.widthErrorText.value!,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16),
                                            ),
                                          );
                                        } else {
                                          return const SizedBox
                                              .shrink(); // Hata yoksa boşluk bırakma
                                        }
                                      }),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          border: Border.all(
                                              color: const Color(0xFFE0E0E0)),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Obx(() => TextField(
                                              controller:
                                                  controller.lengthController,
                                              focusNode:
                                                  controller.lengthFocusNode,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) => controller
                                                  .validateHeight(value),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                hintText: 'Uzynlygy (sm)',
                                                suffixText: 'sm',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: controller
                                                                .heightErrorText
                                                                .value ==
                                                            null
                                                        ? const Color(
                                                            0xFFE0E0E0)
                                                        : Colors.red,
                                                    width: controller
                                                                .heightErrorText
                                                                .value ==
                                                            null
                                                        ? 1.0
                                                        : 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: controller
                                                                .heightErrorText
                                                                .value ==
                                                            null
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Colors.red,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                suffixStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:
                                                        Fonts.gilroySemiBold,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                hintStyle: const TextStyle(
                                                    color: Color(0xFF9E9E9E)),
                                              ),
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            )),
                                      ),
                                      Obx(() {
                                        if (controller.heightErrorText.value !=
                                            null) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0, left: 2.0),
                                            child: Text(
                                              controller.heightErrorText.value!,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16),
                                            ),
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 247, 247),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bellik',
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.green,
                                fontWeight: FontWeight.w600,
                                fontFamily: Fonts.gilroySemiBold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                border:
                                    Border.all(color: const Color(0xFFE0E0E0)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                controller: controller.noteController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                minLines: 3,
                                decoration: InputDecoration(
                                  hintText: 'Bellik giriziň ',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF9E9E9E)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2),
                                  ),
                                ),
                                onChanged: (value) =>
                                    controller.note.value = value,
                              ),
                            ),
                          ]),
                    ),
                  ),
                  if (widget.product.description != null &&
                      widget.product.description!.isNotEmpty) ...[
                    const SizedBox(height: 35),
                    Text(
                      widget.product.description ??
                          "", // Buradaki '?? ""' kullanımı zaten güvenli.
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 110, 110, 112),
                        fontWeight: FontWeight.w400,
                        fontFamily: Fonts.gilroyRegular,
                      ),
                    ),
                  ],
                  const SizedBox(height: 40),
                  Obx(() => Container(
                        color: const Color.fromARGB(255, 247, 250, 252),
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          border: TableBorder.all(color: Color(0xFFE7E7E7)),
                          columnWidths: const <int, TableColumnWidth>{
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(2),
                          },
                          children:
                              (controller.category.value?.attributes ?? [])
                                  .map((attr) {
                            return TableRow(
                              children: [
                                Container(
                                  color:
                                      const Color.fromARGB(255, 247, 250, 252),
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    attr.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: Fonts.gilroyRegular,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    attr.value,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: Fonts.gilroyRegular,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      )),
                  const SizedBox(height: 30),
                  Obx(() {
                    if (controller.filteredProductskopsatylan.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Iň köp satylan halylar',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: Fonts.gilroySemiBold,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 39, 39, 39),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 493,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  controller.filteredProductskopsatylan.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 600 / 231,
                              ),
                              itemBuilder: (context, index) {
                                final product = controller
                                    .filteredProductskopsatylan[index];
                                return ProductCardWidget(product: product);
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  const SizedBox(height: 30),
                  Obx(() {
                    if (controller.filteredProducts.length > 1) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Meňzeş halylar',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: Fonts.gilroySemiBold,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 39, 39, 39),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 493,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.filteredProducts.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 600 / 231,
                              ),
                              itemBuilder: (context, index) {
                                final product =
                                    controller.filteredProducts[index];
                                return ProductCardWidget(product: product);
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  const SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding bottomNavBar(
      ProductDetailController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: FloatingActionButton.extended(
          onPressed: () {
            if (controller.canAddToCart()) {
              final cartItem = controller.getCartItem();

              if (cartItem != null) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddToCartDialog(
                      cartItem: cartItem,
                      onConfirm: () {
                        controller.addProductToCart();
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              } else {
                controller.addProductToCart();
              }
            }
          },
          backgroundColor: AppColors.green,
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/sebet.svg",
                colorFilter:
                    const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              ),
              const SizedBox(width: 12),
              const Text(
                'Sebede goş',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: Fonts.gilroySemiBold,
                    color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
