import 'package:animax/modules/dashboard/dashboard.dart';
import 'package:animax/modules/dashboard/dashboard_widgets/AnimeCard.dart';
import 'package:animax/modules/dashboard/release_calender/ReleaseCalender.dart';
import 'package:animax/utils/services/AnimeService.dart';
import 'package:flutter/material.dart';

import '../../../core/models/anime_detail/anime_detail.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  var content = <AnimeDetail>[];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "My List",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
                Icon(
                  Icons.search,
                  size: 20,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: fetchMyList(0, 10),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    ApiResponse jsonvalue = snapshot.data!;
                    content = jsonvalue.data!.content!;
                    if (content.isEmpty) {
                      return CenterImageWithTextForNoData(
                        text: "Your List is Empty",
                        imageSrc: "assets/images/list_zero.png",
                        desc:
                            "It seems that you haven't added any anime to your list",
                      );
                    }
                    return GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: (150 / 200),
                        scrollDirection: Axis.vertical,
                        children: List.generate(
                            content.length,
                            (index) => GridTile(
                                  key: ObjectKey(content[index]),
                                  header: null,
                                  footer: Container(
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(content[index].animeType ==
                                                  'seasons'
                                              ? 'Series'
                                              : 'Movie'),
                                          IconButton(
                                            tooltip: "Remove from wishlist",
                                            highlightColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            icon: const Icon(Icons.close),
                                            onPressed: () {
                                              removeFromMyList(
                                                  content[index].aid);
                                              content.remove(content[index]);
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  child: AnimeCard(content[index],
                                      key: ObjectKey(content[index])),
                                )));
                  } else {
                    return const CenterProgressIndicator();
                  }
                }),
          )
        ],
      ),
    );
  }
}
