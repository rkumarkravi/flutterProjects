import 'package:flutter/material.dart';

import '../models/todoist_model.dart';

class NoteNode extends StatelessWidget {
  TodoistModel model;
  NoteNode({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 3),
        decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${model.text}',
              style: const TextStyle(color: Colors.black),
            ),
            Text(
              '${model.date}',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
