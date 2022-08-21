import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  String? text;
  DividerWithText({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      const Expanded(child: Divider()),
      Text(
        text ?? "",
        textAlign: TextAlign.center,
      ),
      const Expanded(child: Divider()),
    ]);
  }
}
