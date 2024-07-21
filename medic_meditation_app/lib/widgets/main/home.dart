import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:medic_meditation_app/data/home_data.dart';
import 'package:medic_meditation_app/utils/consts/image_consts.dart';
import 'package:medic_meditation_app/widgets/custom/medic_button_label.dart';
import 'package:medic_meditation_app/widgets/custom/medic_home_card.dart';

import '../../data/pojo/MeditationItem.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> jsonItems = jsonDecode(HomeData.json);
    List<MeditationItem> items =
        jsonItems.map((json) => MeditationItem.fromJson(json)).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20,20,20,0),
      child: Stack(fit: StackFit.expand, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back, Ravi!",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "How are you feeling today ?",
              overflow: TextOverflow.visible,
              softWrap: true,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w100),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MedicButtonLabel(
                  label: "Calm",
                  image: ImageConsts.HOME_ICON_CALM,
                  onPressed: () {
                    print('Calm');
                  },
                ),
                MedicButtonLabel(
                  label: "Relax",
                  image: ImageConsts.HOME_ICON_RELAX,
                  onPressed: () {
                    print('Relax');
                  },
                ),
                MedicButtonLabel(
                  label: "Focus",
                  image: ImageConsts.HOME_ICON_FOCUS,
                  onPressed: () {
                    print('Focus');
                  },
                ),
                MedicButtonLabel(
                  label: "Anxious",
                  image: ImageConsts.HOME_ICON_ANXIOUS,
                  onPressed: () {
                    print('Anxious');
                  },
                ),
              ],
            ),
            
          ],
        ),
        Positioned.fill(
          top: 220,
          child:SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: items.map((x) {
                    return Column(
                      children: [
                        MedicHomeCard(
                          item: x,
                          onPressed: () {
                            print(x.image);
                          },
                        ),const SizedBox(height: 10,)
                      ],
                    );
                  }).toList(),
                ),
              ))
      ]),
    );
  }
}
