import 'package:flutter/material.dart';
import 'package:flutter_application/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Row(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.red,
              padding: const EdgeInsets.all(4),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWithVar(
                        text: context.watch<UserProvider>().userName,
                        color: Colors.white),
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/login.png"),
                    ),
                  ],
                ),
              ),
            ),
            Row()
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          key: Key("addUser"),
          onPressed: () => context.read<UserProvider>().setUserName("My named"),
          child: Icon(Icons.incomplete_circle_outlined),
        ),
      ),
    );
  }
}

class TextWithVar extends StatelessWidget {
  final String text;
  final Color color;
  const TextWithVar({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color),
    );
  }
}
