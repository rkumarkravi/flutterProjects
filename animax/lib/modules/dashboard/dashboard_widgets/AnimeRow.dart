
import 'package:animax/modules/dashboard/dashboard_widgets/AnimeCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/models/anime_detail/anime_detail.dart';
import '../Anime_see_all/AnimeSeeAll.dart';

class AnimeRow extends StatelessWidget {
  final String animeRowName;
  final List<AnimeDetail> rowData;
  const AnimeRow(this.animeRowName, this.rowData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                animeRowName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(()=>AnimeSeeAll(heading: animeRowName));
                },
                child: const Text(
                  "See All",
                  style: TextStyle(color: Color.fromARGB(255, 109, 255, 114)),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: rowData
                    .map<AnimeCard>(
                        (anime) => AnimeCard(anime, key: ObjectKey(anime)))
                    .toList()),
          ),
        ],
      ),
    );
  }
}
