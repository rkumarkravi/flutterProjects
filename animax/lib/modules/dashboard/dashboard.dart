import 'package:animax/core/models/anime_detail/anime_detail.dart';
import 'package:animax/modules/dashboard/dashboarController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'anime_viewer/dashboard_node_view/AnimeRow.dart';
import 'anime_viewer/dashboard_node_view/AnimeWithDetails.dart';

class Dashboard extends StatelessWidget {
  DashboarController dashboardController = Get.put(DashboarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 109, 255, 114),
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded), label: "Release Cal."),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_outlined), label: "My List"),
          BottomNavigationBarItem(
              icon: Icon(Icons.download_for_offline_outlined),
              label: "Download"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: dashboardController.fetchData(0, 5),
            builder:
                (BuildContext context, AsyncSnapshot<AnimeRespone> snapshot) {
              if (snapshot.hasData) {
                AnimeRespone jsonvalue = snapshot.data!;
                return Column(
                  children: [
                    AnimeWithDetails(jsonvalue.content![0],
                        key: const ValueKey(1)),
                    const SizedBox(
                      height: 10,
                    ),
                    AnimeRow(
                      "Top Hits Anime",
                      jsonvalue.content!,
                      key: const ValueKey(2),
                    ),
                    AnimeRow(
                      "New Episode Release",
                      jsonvalue.content!,
                      key: const ValueKey(3),
                    ),
                  ],
                );
              } else {
                return Center(
                  heightFactor: 7,
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                        strokeWidth: 10, color: Colors.green.shade600),
                  ),
                );
              }
            }),
      ),
    );
  }
}
