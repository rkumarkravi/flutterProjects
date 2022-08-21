import 'package:animax/core/models/anime_detail/anime_detail.dart';
import 'package:animax/modules/dashboard/anime_viewer/Anime_see_all/SeeAllNode.dart';
import 'package:animax/modules/dashboard/dashboarController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimeSeeAll extends StatelessWidget {
  String heading = "";
  AnimeSeeAll({Key? key, required String heading}) : super(key: key) {
    this.heading = heading;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          heading,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: Get.find<DashboarController>().fetchData(0, 10),
            builder:
                (BuildContext context, AsyncSnapshot<AnimeRespone> snapshot) {
              int a = 0;
              if (snapshot.hasData) {
                AnimeRespone jsonvalue = snapshot.data!;
                return Column(
                  children: jsonvalue.content!
                      .map<SeeAllNode>((episode) =>
                          SeeAllNode(episode, a++, key: ObjectKey(episode)))
                      .toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
