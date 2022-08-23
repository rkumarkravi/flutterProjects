import 'package:animax/core/custom/AnimeTextField.dart';
import 'package:animax/core/custom/DividerWithText.dart';
import 'package:animax/widgets/image-with-text-button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatelessWidget {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final dobController = TextEditingController();
  final mobNoController = TextEditingController();

  Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Icon(
                Icons.local_fire_department_sharp,
                color: Theme.of(context).primaryColor,
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: 380,
                child: Text(
                  "Create Your Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 380,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 185,
                          child: AnimeTextField(
                            controller: fnameController,
                            hintText: "First Name",
                            filled: true,
                            borderRadius: 10.0,
                            prefixIcon: const Icon(Icons.person),
                          )),
                      SizedBox(
                        width: 185,
                        child: AnimeTextField(
                            controller: lnameController,
                            hintText: "Last Name",
                            filled: true,
                            borderRadius: 10.0,
                            prefixIcon: const Icon(Icons.person)),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
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
                height: 10,
              ),
              SizedBox(
                  width: 380,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 185,
                        child: AnimeTextField(
                            controller: dobController,
                            hintText: "dd/MM/yyyy",
                            filled: true,
                            borderRadius: 10.0,
                            prefixIcon: const Icon(Icons.calendar_month)),
                      ),
                      SizedBox(
                        width: 185,
                        child: AnimeTextField(
                            controller: mobNoController,
                            hintText: "Mobile No.",
                            filled: true,
                            borderRadius: 10.0,
                            prefixIcon: const Icon(Icons.phone)),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 380,
                height: 70,
                child: ImageWithTextButton(
                    color: Colors.green.shade600,
                    text: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              DividerWithText(text: "or continue with"),
              const SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Already have an account ?"),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => {Get.offAllNamed("/login")},
                  child: Text(
                    "Sign in",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
