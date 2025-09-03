import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

import 'package:chewie/chewie.dart';

class MediaViewer extends StatefulWidget {
  final String mediaPath;

  const MediaViewer({super.key, required this.mediaPath});

  @override
  // ignore: library_private_types_in_public_api
  _MediaViewerState createState() => _MediaViewerState();
}

class _MediaViewerState extends State<MediaViewer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isVideo = false;

  @override
  void initState() {
    super.initState();
    if (widget.mediaPath.endsWith('.mp4') ||
        widget.mediaPath.endsWith('.mov') ||
        widget.mediaPath.endsWith('.avi')) {
      _isVideo = true;
      _initializePlayer();
    }
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.mediaPath));
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      showControls: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    if (_isVideo) {
      _videoPlayerController.dispose();
      _chewieController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: _isVideo
            ? (_chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
                ? Chewie(
                    controller: _chewieController!,
                  )
                : const CircularProgressIndicator())
            : PhotoView(
                imageProvider: FileImage(File(widget.mediaPath)),
              ),
      ),
    );
  }
}
