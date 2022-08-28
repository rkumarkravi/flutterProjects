import 'package:animax/core/custom/AnimeTextField.dart';
import 'package:animax/core/models/anime_detail/anime_detail.dart';
import 'package:animax/modules/dashboard/release_calender/ReleaseCalender.dart';
import 'package:animax/modules/dashboard/search_anime/SearchController.dart';
import 'package:animax/modules/dashboard/search_anime/search_child_node.dart';
import 'package:animax/utils/services/AnimeService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  final controller = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AnimeTextField(
                controller: controller.searchTextEditController,
                hintText: "Search",
                filled: true,
                borderRadius: 10.0,
                prefixIcon: const Icon(Icons.search),
                isObscure: false,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => FutureBuilder(
              future: searchAnime(controller.debounceSearchText.value),
              builder: (BuildContext context,
                  AsyncSnapshot<List<AnimeDetail>> snapshot) {
                //debugPrint('${snapshot.data}');
                if (snapshot.hasData) {
                  List<AnimeDetail>? searchResult = snapshot.data;
                  if (searchResult!.isEmpty) {
                    return CenterImageWithTextForNoData(
                      text: "No Result Found",
                      imageSrc: "assets/images/no_release_sch.png",
                      desc: "Sorry, there is no anime found !",
                    );
                  }
                  return SingleChildScrollView(
                    child: Column(
                        children: searchResult.map<SearchChildNode>((e) {
                      return SearchChildNode(e);
                    }).toList()),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        )
      ],
    );
  }
}



//  GetBuilder<SearchController>(builder: ((controller) {
//           var searchNodeVal = controller.searchResult.value;
//           if (searchNodeVal.isNotEmpty) {
//             return ListView.builder(
//                 itemBuilder: ((BuildContext context, index) {
//               return SearchChildNode(searchNodeVal[index]);
//             }));
//           } else {
//             return CenterImageWithTextForNoData(
//               text: "No Result Found",
//               imageSrc: "assets/images/no_release_sch.png",
//               desc: "Sorry, there is no anime found !",
//             );
//           }
//         })),