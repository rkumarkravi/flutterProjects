import 'package:flutter/material.dart';

import '../../data/pojo/MeditationItem.dart';

class MedicHomeCard extends StatelessWidget {
  final MeditationItem item;
  final VoidCallback onPressed;
  const MedicHomeCard({super.key, required this.item, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Stack(
        children: [
          Positioned(
            right: 10,
            top: 20,
              child: item.image.contains('assets')
                  ? Image.asset(item.image,width: 166,height: 111,)
                  : Image.network(item.image,width: 166,height: 111,)),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    item.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    item.description,
                    softWrap: true,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size.fromWidth(138),
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    onPressed: onPressed,
                    child: const Row(
                      children: [
                        Text(
                          'watch now',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.play_circle,
                          color: Colors.white,
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
