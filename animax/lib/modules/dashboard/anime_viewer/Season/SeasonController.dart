import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SeasonController extends GetxController {
  var dropdownVal = RxString("");
  var curentVideoId = "".obs;
  var playVideo = RxBool(false);
  late VideoPlayerController controller;

  onTapVideo(int videoId) {
    final controllerVideo = VideoPlayerController.network(
        "http://localhost:8080/anime/api/v1/downloadFromRes/$videoId");
    controller = controllerVideo;
    controller.initialize().then((_) {
      controller.play();
      playVideo.value = true;
      refresh();
    });
  }
}
