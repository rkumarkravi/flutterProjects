import 'package:animax/core/models/anime_detail/anime_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../constants/UrlConsts.dart';

class SeasonController extends GetxController {
  var dropdownVal = RxString("Season 1");
  var currentVideoId = "".obs;
  var playVideo = RxBool(false);
  late VideoPlayerController controller;
  RxList<Video> filteredVideos = RxList([]);

  onTapVideo(int videoId) {
    //controller!.dispose();
    final controllerVideo = VideoPlayerController.network(
        "$VIDEO_URL$videoId",videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    controller = controllerVideo;
    controller.initialize().then((_) {
      controller.play();
      playVideo.value = true;
      refresh();
    });
  }

  filterVideo(val) {
    debugPrint("filtered !");
    filteredVideos = filteredVideos
        .where((element) => 'Season ${element.seasonNo}'.contains(val))
        .toList()
        .obs;
    debugPrint('${filteredVideos.length}');
    refresh();
  }
}
