import 'dart:async';

import 'package:animax/core/models/anime_detail/anime_detail.dart';
import 'package:animax/modules/dashboard/dashboard_widgets/AnimeWithDetails.dart';
import 'package:animax/modules/dashboard/mylist/MyListPage.dart';
import 'package:animax/modules/dashboard/release_calender/ReleaseCalender.dart';
import 'package:animax/modules/dashboard/search_anime/search.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import '../../core/settings/setting.dart';
import '../../utils/services/AnimeService.dart';
import 'dashboard_widgets/AnimeRow.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var currentIndex = 0;

  final pages = [
    const HomePage(),
    const ReleaseCalender(),
    const MyListPage(),
    Search(),
    // const HomePage(),
    const Setting()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color.fromARGB(255, 109, 255, 114),
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_rounded), label: "Release Cal."),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border_outlined), label: "My List"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.download_for_offline_outlined),
            //     label: "Download"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
        ),
        body: SingleChildScrollView(child: pages[currentIndex]),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var animateHeroAnime = RxInt(0);
    return FutureBuilder(
        future: fetchData(0, 5),
        builder: (BuildContext context, AsyncSnapshot<AnimeRespone> snapshot) {
          if (snapshot.hasData) {
            AnimeRespone jsonvalue = snapshot.data!;
            int totalLength = snapshot.data!.content!.length;
            Timer.periodic(const Duration(seconds: 20), (timer) {
              // debugPrint(timer.tick.toString());
              if (totalLength - 1 == animateHeroAnime.value) {
                animateHeroAnime.value = 0;
              } else {
                animateHeroAnime++;
              }
              animateHeroAnime.refresh();
            });
            return Column(
              children: [
                Obx(
                  () => AnimeWithDetails(
                      jsonvalue.content![animateHeroAnime.value],
                      key: const ValueKey(1)),
                ),
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
            return const CenterProgressIndicator();
          }
        });
  }
}

class CenterProgressIndicator extends StatelessWidget {
  const CenterProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
