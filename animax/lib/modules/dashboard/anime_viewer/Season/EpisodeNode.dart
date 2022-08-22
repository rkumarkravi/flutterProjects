import 'package:animax/modules/dashboard/anime_viewer/Season/SeasonController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/UrlConsts.dart';
import '../../../../core/models/anime_detail/anime_detail.dart';

class EpisodeNode extends StatelessWidget {
  Video video;
  int episodeNo;
  SeasonController seasonController = Get.put(SeasonController());

  EpisodeNode(this.video, this.episodeNo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => {
            debugPrint('${video.vid}'),
            seasonController.playVideo.value = false,
            seasonController.playVideo.refresh(),
            seasonController.onTapVideo(video.videoBlobFile!.vbId!)
          },
          child: Stack(
            children: [
              Image.network(
               IMAGE_URL +
                    '${video.thumbnail?.tid}',
                height: 100,
                width: 150,
                fit: BoxFit.fitHeight,
              ),
              Positioned(
                child: Text(
                  'Episode ${episodeNo + 1}',
                  style: const TextStyle(backgroundColor: Colors.black),
                ),
                bottom: 5,
                left: 5,
              ),
              const Positioned(
                  child: Icon(Icons.play_circle_fill_rounded),
                  left: 60,
                  top: 40)
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
