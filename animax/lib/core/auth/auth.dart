// ignore_for_file: unnecessary_const

import 'package:animax/widgets/image-with-text-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Image(
                width: 250,
                height: 250,
                image: const Svg('assets/images/login.svg')),
            const Text(
              "Let's you in",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ImageWithTextButton(
                    margin: 10,
                    padding: 10,
                    icon: const Icon(Icons.facebook, color: Colors.green),
                    text: const Text(
                      "Login with facebook",
                      style: const TextStyle(color: Colors.white),
                    )),
                ImageWithTextButton(
                    margin: 10,
                    padding: 10,
                    icon: const Icon(Icons.accessible_outlined,
                        color: Colors.green),
                    text: const Text(
                      "Login with Google",
                      style: const TextStyle(color: Colors.white),
                    )),
                ImageWithTextButton(
                    margin: 10,
                    padding: 10,
                    icon: const Icon(Icons.apple, color: Colors.green),
                    text: const Text(
                      "Login with Apple",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            const Divider(
              height: 5,
              thickness: 2,
              indent: 50,
              endIndent: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (() {
                    Get.offAllNamed('/login');
                  }),
                  child: ImageWithTextButton(
                      margin: 10,
                      padding: 10,
                      color: Theme.of(context).primaryColor,
                      text: const Text(
                        "Sign in with password",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Don't have an account?"),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () => {Get.offAllNamed("/signup")},
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
