import 'package:flutter/material.dart';
import 'package:flutter_application/home-page.dart';
import 'package:flutter_application/loader.dart';
import 'package:flutter_application/providers/UserProvider.dart';
import 'package:provider/provider.dart';
import 'login.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginPage(),
        '/loader': (context) => const LoaderPage(),
        '/home': (context) => const HomePage(),
      },
      initialRoute: "/login",
    );
  }
}
