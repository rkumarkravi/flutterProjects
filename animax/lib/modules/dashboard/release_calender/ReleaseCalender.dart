import 'package:animax/core/models/anime_detail/anime_detail.dart';
import 'package:animax/modules/dashboard/dashboard.dart';
import 'package:animax/modules/dashboard/dashboard_widgets/AnimeCard.dart';
import 'package:animax/utils/services/AnimeService.dart';
import 'package:flutter/material.dart';

class ReleaseCalender extends StatefulWidget {
  const ReleaseCalender({Key? key}) : super(key: key);

  @override
  State<ReleaseCalender> createState() => _ReleaseCalenderState();
}

class _ReleaseCalenderState extends State<ReleaseCalender> {
  String currentDate = getDates(1)[0]['dateForSearch'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text("Release Calender",
                  style: TextStyle(
                      fontFamily: "seoge",
                      fontSize: 20,
                      fontStyle: FontStyle.normal))),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: getDates(20).map((e) {
              return InkWell(
                onTap: () {
                  currentDate = e['dateForSearch'];
                  setState(() {});
                },
                child: DateChip(
                  key: ObjectKey(e),
                  date: e['date'],
                  dayName: e['day'],
                ),
              );
            }).toList()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: getByDate(currentDate),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      List<AnimeDetail> content = snapshot.data!;
                      if (content.isEmpty) {
                        return CenterImageWithTextForNoData(
                          text: "No Release Schedule",
                          imageSrc: "assets/images/no_release_sch.png",
                          desc:
                              "Sorry, there is no anime release schedule on this date",
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
                                    footer: null,
                                    child: AnimeCard(content[index],
                                        key: ObjectKey(content[index])),
                                  )));
                    } else {
                      return const CenterProgressIndicator();
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class CenterImageWithTextForNoData extends StatelessWidget {
  var text;

  var imageSrc;

  var desc;

  CenterImageWithTextForNoData({Key? key, this.text, this.imageSrc, this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        heightFactor: 2,
        child: Column(
          children: [
            imageSrc != null
                ? Image(
                    width: 300,
                    colorBlendMode: BlendMode.color,
                    image: AssetImage(imageSrc))
                : const SizedBox(),
            const SizedBox(
              height: 20,
            ),
            Text(
              text ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.green),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              desc ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ));
  }
}

class DateChip extends StatelessWidget {
  final date;
  final dayName;

  const DateChip({Key? key, this.dayName, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 50,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(142, 224, 224, 224)),
          borderRadius: BorderRadius.circular(50),
          color: Colors.black26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('$dayName'),
          const SizedBox(
            height: 20,
          ),
          Text(
            '$date',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }
}
