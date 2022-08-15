import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerUsername = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/login.png",
                fit: BoxFit.fitWidth,
                height: 300,
              ),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controllerUsername,
                        autofocus: true,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: controllerPassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  String username = controllerUsername.text;
                  String password = controllerPassword.text;
                  if (username == "admin" && password == "admin") {
                    Navigator.pushNamed(context, "/loader");
                  } else {
                    print("wrong user or password");
                  }
                },
                child: const Text("Login"),
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20)),
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Forgot Password ?"),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => {print("forgot password clicked")},
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                )
              ]),
            ],
          ),
        ));
  }
}
