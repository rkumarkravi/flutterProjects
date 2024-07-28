import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/music_controller.dart';

class MusicPlayerScreen extends StatelessWidget {
  final MusicController musicController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // const CircleAvatar(
        //   radius: 100,
        //   backgroundImage: ,
        // ),

        ClipOval(
          child: Image.asset(
            'assets/images/AlbumArt.png',
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => Text(textAlign: TextAlign.center,
            musicController.currentSong.value.title,
            style: const TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Obx(
          () => Text(
            musicController.currentSong.value.artist,
            style: const TextStyle(color: Colors.white70, fontSize: 25),
          ),
        ),

        const SizedBox(height: 20),
        Obx(
          () => Slider(
            value: musicController.position.value.inSeconds.toDouble(),
            max: musicController.duration.value.inSeconds.toDouble(),
            onChanged: (value) {
              musicController.seekTo(Duration(seconds: value.toInt()));
            },
          ),
        ),
        Obx(() {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${musicController.position.value.inMinutes}:${musicController.position.value.inSeconds}'),
                Text('${musicController.duration.value.inMinutes}:${musicController.duration.value.inSeconds}')
              ],
            ),
          );
        }),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.keyboard_double_arrow_left,
                  color: Colors.white, size: 64),
              onPressed: musicController.previousPlay,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Obx(() {
                if (musicController.isPlaying.value) {
                  print('play');
                  return IconButton(
                    icon: Icon(Icons.pause,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        size: 64),
                    onPressed: musicController.pause,
                  );
                } else {
                  print('pause');
                  return IconButton(
                    icon: Icon(Icons.play_arrow,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        size: 64),
                    onPressed: musicController.play,
                  );
                }
              }),
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_double_arrow_right,
                  color: Colors.white, size: 64),
              onPressed: musicController.nextPlay,
            ),
          ],
        ),
      ],
    );
  }
}
