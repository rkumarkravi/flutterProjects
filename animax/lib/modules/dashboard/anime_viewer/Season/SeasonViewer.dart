import 'package:animax/core/models/anime_detail/anime_detail.dart';
import 'package:animax/modules/dashboard/anime_viewer/Season/EpisodeNode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SeasonController.dart';

class SeasonViewer extends StatelessWidget {
  List<Video> videos;
  bool isSeason = false;
  SeasonViewer(this.videos, {Key? key, bool? isSeason}) : super(key: key) {
    this.isSeason = isSeason!;
  }

  SeasonController seasonController =
      Get.put(SeasonController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Episodes"),
            isSeason
                ? Obx(() => DropdownButton<String>(
                      hint: seasonController.dropdownVal.value == ""
                          ? const Text("Season 1")
                          : Text(seasonController.dropdownVal.value),
                      items:
                          <String>['Season 1', 'Season 2'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        print(seasonController.dropdownVal.value);
                        seasonController.dropdownVal.value = '$val';
                      },
                    ))
                : SizedBox()
          ],
        ),
        if (videos.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: videos
                    .map<EpisodeNode>((episode) => EpisodeNode(
                        episode, videos.indexOf(episode),
                        key: ObjectKey(episode)))
                    .toList()),
          ),
      ],
    );
  }
}
