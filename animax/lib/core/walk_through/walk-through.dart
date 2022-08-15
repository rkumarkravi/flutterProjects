import 'package:flutter/material.dart';

class WalkThrough extends StatelessWidget {
  const WalkThrough({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.darken),
                fit: BoxFit.fitHeight,
                image: const AssetImage("assets/images/anime_walk.png"))),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Welcome to Animax",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "The beat streaming anime app of the century to entertain you every day",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: const Text('Get Started',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, wordSpacing: 5)),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
