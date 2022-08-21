import 'package:flutter/material.dart';

class ImageWithTextButton extends StatelessWidget {
  Icon? icon;
  final Text text;
  Color? color;
  double? padding;
  double? margin;
  ImageWithTextButton(
      {Key? key,
      this.icon,
      required this.text,
      this.color,
      this.padding,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      padding: EdgeInsets.all(padding ?? 0),
      margin: EdgeInsets.all(margin ?? 10),
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? const SizedBox(),
          const SizedBox(
            width: 10,
          ),
          text
        ],
      ),
    );
  }
}
