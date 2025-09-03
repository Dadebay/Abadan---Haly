import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MediaDisplayWidget extends StatefulWidget {
  final String filePath;

  const MediaDisplayWidget({Key? key, required this.filePath}) : super(key: key);

  @override
  _MediaDisplayWidgetState createState() => _MediaDisplayWidgetState();
}

class _MediaDisplayWidgetState extends State<MediaDisplayWidget> {
  VideoPlayerController? _videoPlayerController;
  bool _isVideo = false;

  @override
  void initState() {
    super.initState();
    _checkMediaType();
  }

  void _checkMediaType() {
    final fileExtension = widget.filePath.split('.').last.toLowerCase();
    if (['mp4', 'mov', 'avi', 'mkv'].contains(fileExtension)) {
      _isVideo = true;
      _videoPlayerController = VideoPlayerController.file(File(widget.filePath))
        ..initialize().then((_) {
          setState(() {});
        });
    } else {
      _isVideo = false;
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isVideo) {
      return _videoPlayerController!.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController!.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController!),
            )
          : const Center(child: CircularProgressIndicator());
    } else {
      return Image.file(
        File(widget.filePath),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 200,
      );
    }
  }
}
