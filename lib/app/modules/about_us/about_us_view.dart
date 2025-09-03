import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:haly/app/modules/about_us/controller.dart';
import 'package:haly/app/modules/about_us/midea_viewer.dart';
import 'package:haly/app/modules/about_us/widgets/about_us_header.dart';
import 'package:haly/app/widgets/custom_app_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AboutUsView extends StatelessWidget {
  AboutUsView({super.key});
  final AboutController controller = Get.put(AboutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: GetX<AboutController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return Center(
                child: SizedBox(
                    width: 40,
                    height: 40,
                    child:
                        Lottie.asset('assets/images/processing-circle.json')));
          }
          if (controller.hasError.value || controller.about.value == null) {
            return const Center(child: Text("Hakkımızda bilgisi yüklenemedi."));
          }

          return _buildContentView(context, controller);
        },
      ),
    );
  }

  Widget _buildContentView(BuildContext context, AboutController controller) {
    final aboutData = controller.about.value!;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 24.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AboutUsHeader(),
          Html(
            data: aboutData.title,
            style: {
              "p": Style(),
              "strong": Style(fontWeight: FontWeight.bold),
            },
          ),
          const SizedBox(height: 24),
          if (aboutData.files.isNotEmpty)
            _AboutMediaSlider(
              mediaPaths: aboutData.files,
            ),
          const SizedBox(height: 16),
          Html(
            data: aboutData.description,
            style: {
              "p": Style(),
              "strong": Style(fontWeight: FontWeight.bold),
            },
          ),
        ],
      ),
    );
  }
}

class VideoThumbnailWidget extends StatefulWidget {
  final String videoPath;

  const VideoThumbnailWidget({Key? key, required this.videoPath})
      : super(key: key);

  @override
  _VideoThumbnailWidgetState createState() => _VideoThumbnailWidgetState();
}

class _VideoThumbnailWidgetState extends State<VideoThumbnailWidget> {
  String? _thumbnailPath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  Future<void> _generateThumbnail() async {
    try {
      final thumbnail = await VideoThumbnail.thumbnailFile(
        video: widget.videoPath,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.WEBP,
        quality: 50,
      );
      if (mounted) {
        setState(() {
          _thumbnailPath = thumbnail;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      print('Error generating thumbnail for ${widget.videoPath}: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_thumbnailPath != null) {
      return Image.file(
        File(_thumbnailPath!),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading thumbnail from $_thumbnailPath: $error');
          return Image.asset('assets/images/about1.jpg', fit: BoxFit.cover);
        },
      );
    } else {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Icon(Icons.error_outline, color: Colors.white),
        ),
      );
    }
  }
}

class _AboutMediaSlider extends StatelessWidget {
  final List<String> mediaPaths;

  const _AboutMediaSlider({required this.mediaPaths});

  @override
  Widget build(BuildContext context) {
    const double imageHeight = 283;
    final double cardWidth = MediaQuery.of(context).size.width * 0.45;

    return SizedBox(
      height: imageHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemCount: mediaPaths.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12.0),
        itemBuilder: (context, index) {
          final mediaPath = mediaPaths[index];
          final isVideo = mediaPath.toLowerCase().endsWith('.mp4') ||
              mediaPath.toLowerCase().endsWith('.mov') ||
              mediaPath.toLowerCase().endsWith('.avi');

          return SizedBox(
            width: cardWidth,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MediaViewer(mediaPath: mediaPath),
                  ),
                );
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                elevation: 3.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (isVideo)
                      VideoThumbnailWidget(videoPath: mediaPath)
                    else
                      Image.file(
                        File(mediaPath),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image from $mediaPath: $error');
                          return Image.asset('assets/images/about1.jpg',
                              fit: BoxFit.cover);
                        },
                      ),
                    if (isVideo)
                      const Center(
                        child: Icon(
                          Icons.play_circle_fill,
                          color: Colors.white70,
                          size: 50,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
