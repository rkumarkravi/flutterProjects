import 'package:animax/core/auth/auth.dart';
import 'package:animax/core/auth/login/login.dart';
import 'package:animax/core/auth/signup/signup.dart';
import 'package:animax/core/walk_through/splash-screen.dart';
import 'package:animax/modules/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/walk_through/walk-through.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          canvasColor: const Color.fromARGB(255, 27, 27, 27),
          brightness: Brightness.dark,
          primarySwatch: Colors.green,
          primaryColor: Colors.green,
          backgroundColor: Colors.black,
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          )),
      initialRoute: "/splash",
      getPages: [
        GetPage(name: "/splash", page: () => const SplashScreen()),
        GetPage(name: '/walk', page: () => const WalkThrough()),
        GetPage(name: '/auth', page: () => const Auth()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/signup', page: () => Signup()),
        GetPage(name: '/dashboard', page: () => Dashboard()),
      ],
      unknownRoute: GetPage(name: "/notFound", page: () => Dashboard()),
    );
  }
}
