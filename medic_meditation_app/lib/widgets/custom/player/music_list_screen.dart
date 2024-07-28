import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/music_controller.dart';

class MusicListScreen extends StatelessWidget {
  final MusicController musicController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
          padding: const EdgeInsets.all(16),
          children: musicController.songs.map((s) {
            return Card(
              color: Colors.transparent,
              child: ListTile(
                leading: Image.asset('assets/images/AlbumArt.png'),
                title: Text(s.title, style: const TextStyle(color: Colors.white)),
                subtitle: const Text('5 Min',
                    style: TextStyle(color: Colors.white70)),
                // trailing: const Text('59899 Listening',
                //     style: TextStyle(color: Colors.white70)),
                onTap: () {
                  musicController.playSong(s);
                },
              ),
            );
          }).toList()
          /*
          * [
          Card(
            color: Colors.transparent,
            child: ListTile(
              leading: Image.asset('assets/images/AlbumArt.png'),
              title: const Text(
                  'Painting Forest', style: TextStyle(color: Colors.white)),
              subtitle: const Text(
                  '20 Min', style: TextStyle(color: Colors.white70)),
              trailing: const Text(
                  '59899 Listening', style: TextStyle(color: Colors.white70)),
              onTap: musicController.playMusic,
            ),
          ),
          Card(
            color: Colors.grey[800],
            child: ListTile(
              leading: Image.asset('assets/images/AlbumArt.png'),
              title: const Text(
                  'Mountaineers', style: TextStyle(color: Colors.white)),
              subtitle: const Text(
                  '15 Min', style: TextStyle(color: Colors.white70)),
              trailing: const Text(
                  '45697 Listening', style: TextStyle(color: Colors.white70)),
              onTap: musicController.playMusic,
            ),
          ),
          // Add more ListTile widgets as needed
        ],*/
          );
    });
  }
}
