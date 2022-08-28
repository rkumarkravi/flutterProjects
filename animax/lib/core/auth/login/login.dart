import 'package:animax/core/custom/AnimeTextField.dart';
import 'package:animax/core/custom/DividerWithText.dart';
import 'package:animax/widgets/image-with-text-button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/services/AuthService.dart';

class Login extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Icon(
              Icons.local_fire_department_sharp,
              color: Theme.of(context).primaryColor,
              size: 100,
            ),
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              width: 380,
              child: Text(
                "Login to Your Account",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                width: 380,
                child: AnimeTextField(
                    controller: emailController,
                    hintText: "Email",
                    filled: true,
                    borderRadius: 10.0,
                    prefixIcon: const Icon(Icons.email))),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 380,
                child: AnimeTextField(
                  controller: passController,
                  hintText: "Password",
                  filled: true,
                  borderRadius: 10.0,
                  prefixIcon: const Icon(Icons.password),
                  isObscure: true,
                )),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 380,
              height: 70,
              child: InkWell(
                onTap: () async {
                  //Get.offAllNamed("/dashboard");
                  debugPrint(emailController.text + "," + passController.text);
                  var res = await attemptLogIn(
                      emailController.text, passController.text);
                  String msg, type;
                  if (res['access_token'] != null) {
                    msg = "Login Successfully";
                    type = "Info";
                    Get.offAllNamed("/dashboard");
                  } else {
                    msg = "Something Went Wrong!!";
                    type = "Error";
                  }
                  Get.snackbar(type, msg,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: const EdgeInsets.all(8.0));
                },
                child: ImageWithTextButton(
                    color: Colors.green.shade600,
                    text: const Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            DividerWithText(text: "or create account"),
            const SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Dont have an account ?"),
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
        ),
      ),
    );
  }
}
