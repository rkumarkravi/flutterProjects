import 'package:flutter/material.dart';

class ImageWithTextButton extends StatelessWidget {
  Icon? _icon;
  final Text text;
  Color? _color;
  ImageWithTextButton({Key? key, Icon? icon, required this.text, Color? color})
      : super(key: key) {
    _color = color;
    _icon = icon;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: _color ?? Theme.of(context).backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _icon ?? SizedBox(),
          const SizedBox(
            width: 10,
          ),
          text
        ],
      ),
    );
  }
}
