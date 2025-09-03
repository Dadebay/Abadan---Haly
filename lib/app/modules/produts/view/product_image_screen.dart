import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:lottie/lottie.dart';

class ImageZoomScreen extends StatelessWidget {
  final String imagePath;
  final String productCode;
  final String productName;

  const ImageZoomScreen({
    super.key,
    required this.imagePath,
    required this.productCode,
    required this.productName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PhotoView(
              imageProvider: FileImage(File(imagePath)),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 4,
              backgroundDecoration: const BoxDecoration(color: Colors.white),
              loadingBuilder: (context, event) => Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Lottie.asset('assets/images/processing-circle.json'),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 12,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                    icon: const Icon(
                      HugeIcons.strokeRoundedArrowLeft01,
                      size: 30,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    padding: const EdgeInsets.all(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
