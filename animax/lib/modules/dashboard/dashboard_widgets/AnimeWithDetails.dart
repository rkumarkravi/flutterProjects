import 'package:animax/core/models/anime_detail/anime_detail.dart';
import 'package:animax/modules/dashboard/anime_viewer/AnimeViewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimeWithDetails extends StatelessWidget {
  AnimeDetail animeDetail;
  AnimeWithDetails(this.animeDetail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Opacity(
        opacity: 0.5,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            animeDetail.animeBackdrop ?? "",
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      Positioned(
        left: 20,
        top: 20,
        child: Opacity(
          opacity: 0.8,
          child: Icon(
            Icons.local_fire_department_sharp,
            color: Colors.green.shade400,
            size: 40,
          ),
        ),
      ),
      Positioned(
        width: 310,
        left: 20,
        bottom: 20,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(animeDetail.name ?? "",
              style: const TextStyle(fontSize: 30), textAlign: TextAlign.left),
          const SizedBox(
            height: 7,
          ),
          Text(
            animeDetail.description ?? "",
            style: const TextStyle(fontSize: 10),
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                label: const Text(
                  "Play",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.play_circle,
                  color: Colors.white,
                ),
                onPressed: () => {Get.to(AnimeViewer(animeDetail))},
              ),
              const SizedBox(
                width: 20,
              ),
              OutlinedButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
                label: const Text(
                  "My List",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () => {},
              )
            ],
          )
        ]),
      )
    ]);
  }
}
