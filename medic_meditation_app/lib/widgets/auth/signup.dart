import 'package:flutter/material.dart';

import '../../utils/consts/image_consts.dart';
import '../custom/medic_bigger_button.dart';
    
class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                    "Sign Up",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Sign up now for free and start meditating, and explore Medic.",
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
                        const InputDecoration(hintText: "Name"),
                  ),
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
              bottom: 200,
              left: 35,
              right:35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MedicBiggerButton(
                    onPressed: () {
                      print("Signup Clicked!");
                    },
                    text: 'SIGNUP',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account ?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child:  Text(
                          'Sign In',
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