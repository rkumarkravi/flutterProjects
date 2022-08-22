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
  SeasonController seasonController = Get.put(SeasonController());
  @override
  Widget build(BuildContext context) {
    seasonController.filteredVideos.value = videos;
    List<String> seasons = [];
    for (var element in videos) {
      seasons.add('Season ${element.seasonNo}');
    }
    seasons = seasons.toSet().toList().reversed.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isSeason
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Episodes"),
                  Obx(() => DropdownButton<String>(
                        hint: seasonController.dropdownVal.value == ""
                            ? const Text("Season 1")
                            : Text(seasonController.dropdownVal.value),
                        items: seasons.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (val) {
                          seasonController.dropdownVal.value = '$val';
                          seasonController.dropdownVal.refresh();
                          debugPrint(seasonController.dropdownVal.value);
                        },
                      ))
                ],
              )
            : const SizedBox(),
        if (seasonController.filteredVideos.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(
              () {
                var a = 0;
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: seasonController.filteredVideos
                        .where((element) => 'Season ${element.seasonNo}'
                            .contains(seasonController.dropdownVal))
                        .toList()
                        .map<EpisodeNode>((episode) =>
                            EpisodeNode(episode, a++, key: ObjectKey(episode)))
                        .toList());
              },
            ),
          ),
      ],
    );
  }
}
