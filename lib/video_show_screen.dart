import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'Utilies/ControlsOverlay.dart';

class VideoShowScreen extends StatefulWidget {
  final String videoFile;

  const VideoShowScreen({Key? key, required this.videoFile}) : super(key: key);

  @override
  State<VideoShowScreen> createState() => _VideoShowScreenState();
}

class _VideoShowScreenState extends State<VideoShowScreen> {
  late VideoPlayerController _controller;
  bool _isPlay = true;
  Future<void> getVideo({String? videoUrl}) async {
    _controller = VideoPlayerController.network(
      widget.videoFile,
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    // _controller.initialize();
    _controller.initialize().then((value) {
      _controller.play();

      /// For this
      /// when we enter the screen then video are start
    });

    // _controller.setLooping(true);
  }

  @override
  void initState() {
    getVideo();
    // TODO: implement initState
    super.initState();
  }

  @override

  /// Required
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Video '),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          centerTitle: true),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: VideoPlayer(_controller),
            ),
            ControlsOverlay(controller: _controller),
            Align(
                alignment: Alignment.bottomCenter,
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                      playedColor: Colors.green,
                      backgroundColor: Colors.red,
                      bufferedColor: Colors.grey),
                  padding: EdgeInsets.all(25),
                )),
            _isPlay == false
                ? InkWell(
                    onTap: () {
                      setState(() {
                        _isPlay = true;
                      });
                      _controller.play();
                    },
                    child: Icon(Icons.play_arrow,
                        color: Colors.white, size: Get.height * 0.15),
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        _isPlay = false;
                      });
                      _controller.pause();
                    },
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
