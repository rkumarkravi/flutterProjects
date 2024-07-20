import 'package:flutter/material.dart';

import 'landing.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToHome();
  }
  
  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Landing()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/splash_background.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Image.asset('assets/images/logo.png'),
          ),
        ],
      ),
    );
  }
}
