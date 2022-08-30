import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player_/video_show_screen.dart';

class VideoRecordScreen extends StatefulWidget {
  const VideoRecordScreen({Key? key}) : super(key: key);

  @override
  State<VideoRecordScreen> createState() => _VideoRecordScreenState();
}

class _VideoRecordScreenState extends State<VideoRecordScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? photo;

  Future<void> videos() async {
    photo = await _picker.pickVideo(source: ImageSource.camera);
    print('PHOTOPATH>>${photo!.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
              onPressed: () async {
                await videos().then((value) {});
                Get.to(
                  VideoShowScreen(
                    videoFile: photo!.path.toString(),
                  ),
                );
              },
              child: Text('Start Recording')),
        ),
      ),
    );
  }
}
