import 'dart:convert';

import 'package:animax/core/models/anime_detail/anime_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class SeasonController extends GetxController {
  var dropdownVal = RxString("Season 1");
  var curentVideoId = "".obs;
  var playVideo = RxBool(false);
  late VideoPlayerController controller;
  RxList<Video> filteredVideos = RxList([]);

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

  filterVideo(val) {
    debugPrint("filtered !");
    filteredVideos = filteredVideos
        .where((element) => 'Season ${element.seasonNo}'.contains(val))
        .toList()
        .obs;
    debugPrint('${filteredVideos.length}');
    refresh();
  }

  Future<AnimeDetail> fetchDataInitialLoad(animeId) async {
    //http://localhost:8080/anime/api/v1/anime/getAll
    final response = await http.get(
        Uri(
            scheme: 'http',
            host: 'localhost',
            port: 8080,
            path: 'anime/api/v1/anime/get/$animeId/1'),
        headers: {'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return AnimeDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
