import 'package:animax/core/models/anime_detail/anime_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'anime_viewer/AnimeViewer.dart';

class AnimeCard extends StatelessWidget {
  final AnimeDetail animeDetail;
  const AnimeCard(this.animeDetail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {Get.to(AnimeViewer(animeDetail))},
      child: Row(
        children: [
          Stack(
            children: [
              Image.network(
                animeDetail.animeBackdrop ?? "",
                height: 200,
                width: 150,
                fit: BoxFit.cover,
              ),
              Positioned(
                width: 100,
                child: Text(
                  '${animeDetail.name}',
                  style: const TextStyle(
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black,
                        offset: Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                ),
                top: 10,
                left: 5,
              )
            ],
          ),
          const SizedBox(width: 10)
        ],
      ),
    );
  }
}
