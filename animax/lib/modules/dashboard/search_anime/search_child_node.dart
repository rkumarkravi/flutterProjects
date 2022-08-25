import 'package:animax/modules/dashboard/anime_viewer/AnimeViewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/models/anime_detail/anime_detail.dart';

class SearchChildNode extends StatelessWidget {
  final AnimeDetail animeDetail;
  const SearchChildNode(this.animeDetail, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {Get.to(AnimeViewer(animeDetail))},
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    animeDetail.animeBackdrop ?? "",
                    height: 200,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      animeDetail.name ?? "",
                      style: const TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${animeDetail.dateOfRelease}',
                    style: TextStyle(color: Colors.green.shade600),
                  ),
                  const SizedBox(height: 70),
                  SizedBox(
                    width: 230,
                    height: 70,
                    child: Text(
                      '${animeDetail.description}',
                      style: const TextStyle(fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
