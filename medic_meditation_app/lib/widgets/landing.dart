import 'package:flutter/material.dart';
import 'package:medic_meditation_app/utils/consts/image_consts.dart';
import 'package:medic_meditation_app/widgets/auth/signin.dart';

import 'custom/medic_bigger_button.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImageConsts.BIG_LOGO,
                height: 199,
                width: 191,
              ),
              const SizedBox(height: 30),
              const Text(
                'WELCOME',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Alegreya'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Do meditation. Stay focused. Live a healthy life.",
                  overflow: TextOverflow.visible,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Alegreya Sans'),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Column(
              children: [
                MedicBiggerButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const Signin()));
                    // Navigate to the next screen or perform your action
                  },
                  text: 'Login With Email',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to the sign up screen or perform your action
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
