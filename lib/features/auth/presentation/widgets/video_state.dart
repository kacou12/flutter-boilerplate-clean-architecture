import 'package:video_player/video_player.dart';

class VideoState {
static  late VideoPlayerController controller;

  static void initialize() {
    controller = VideoPlayerController.networkUrl(
      Uri.parse(  'https://videocdn.cdnpk.net/joy/content/video/free/video0460/large_preview/_import_60cd8646054bc3.82890625.mp4?filename=1105980_1080p_4k_2k_3840x2160.mp4',
      )
    )..initialize().then((_) {
      controller.play();
      controller.addListener(() {
        if (controller.value.isCompleted) {
          controller.seekTo(const Duration(seconds: 0));
          controller.play();
        }
      });
    });
  }

  static void dispose() {
    controller.dispose();
  }
}