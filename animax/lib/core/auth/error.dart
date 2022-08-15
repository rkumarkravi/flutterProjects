import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Error extends StatelessWidget {
  const Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.back();
    return Scaffold(
      appBar: AppBar(
        title: const Text('404'),
      ),
      body: Container(),
    );
  }
}
