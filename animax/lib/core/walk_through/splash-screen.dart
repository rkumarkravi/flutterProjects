import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 5000), () {
      Get.offNamed('/walk');
    });
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.animation_rounded,
              color: Theme.of(context).primaryColor,
              size: 200,
            ),
            const SizedBox(
              height: 90,
            ),
            Icon(
              Icons.local_fire_department_sharp,
              color: Theme.of(context).primaryColor,
              size: 60,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Loading",
              style: TextStyle(color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
