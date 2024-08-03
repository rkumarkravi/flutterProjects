import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/consts/image_consts.dart';
import 'landing.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    print("splash!");
    super.initState();
    _navigateToHome();
  }
  
  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    // Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (_) => const Landing()));
    Get.toNamed("/landing");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            ImageConsts.SPLASH_LANDING_BG,
            fit: BoxFit.cover,
          ),
          Center(
            child: Image.asset(ImageConsts.BIG_LOGO),
          ),
        ],
      ),
    );
  }
}
