import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/music_controller.dart';
import '../../widgets/custom/player/music_list_screen.dart';
import '../../widgets/custom/player/music_player_screen.dart';

class Sounds extends StatefulWidget {
  const Sounds({Key? key}) : super(key: key);

  @override
  _SoundsState createState() => _SoundsState();
}

class _SoundsState extends State<Sounds> {
  final MusicController musicController = Get.put(MusicController());
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Obx(() {
        return musicController.showPlayer.value? Positioned(
          child: IconButton(
            icon: const Icon(Icons.arrow_drop_down_circle_outlined,
                color: Colors.white, size: 64),
            onPressed: musicController.showSongsQueue,
          )
        ):SizedBox(height: 0,);
      }),
      Obx(() {
        return musicController.showPlayer.value
            ? MusicPlayerScreen()
            : MusicListScreen();
      }),
    ]);
  }
}
