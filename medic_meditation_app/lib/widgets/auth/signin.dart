import 'package:flutter/material.dart';
import 'package:medic_meditation_app/utils/consts/image_consts.dart';
import 'package:medic_meditation_app/widgets/auth/signup.dart';
import 'package:medic_meditation_app/widgets/main/main_app.dart';

import '../custom/medic_bigger_button.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            ImageConsts.LOGIN_SIGNUP_BG,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 101,
            left: 35,
            child: Image.asset(ImageConsts.SMALL_LOGO),
          ),
          Positioned(
              top: 181,
              left: 35,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign In",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Sign in now to acces your excercises and saved music.",
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w100),
                  )
                ],
              )),
          Positioned(
              top: 333,
              left: 35,
              right: 35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: "Email Address"),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InkWell(
                      onTap: () {
                        print("Forgot password CLicked!");
                      },
                      child: Text(
                        "Forgot Password?",
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.end,
                      ))
                ],
              )),
          Positioned(
              bottom: 260,
              left: 35,
              right: 35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MedicBiggerButton(
                    onPressed: () {
                      print("Login Clicked!");
                      Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const MainApp()));
                    },
                    text: 'LOGIN',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account ?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Signup()));
                        },
                        child:  Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.titleMedium
                        ),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
