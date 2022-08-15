import 'package:flutter/material.dart';

class LoaderPage extends StatelessWidget {
  const LoaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/welcome.png",
            ),
            const Text("Welcome ...",
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Roboto",
                    color: Color.fromARGB(249, 81, 70, 243),
                    fontWeight: FontWeight.bold)),
          ]),
    );
  }
}
