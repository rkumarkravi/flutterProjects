import 'package:animax/core/models/anime_detail/anime_detail.dart';
import 'package:animax/modules/dashboard/Anime_see_all/SeeAllNode.dart';
import 'package:flutter/material.dart';
import '../../../utils/services/AnimeService.dart';

class AnimeSeeAll extends StatelessWidget {
  String heading = "";
  AnimeSeeAll({Key? key, required this.heading}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          heading,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: fetchData(0, 10),
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
