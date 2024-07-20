import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todoist/responsiveLayout/DesktopScaffold.dart';
import 'package:todoist/responsiveLayout/MobileScaffold.dart';
import 'package:todoist/responsiveLayout/ResponsiveScaffold.dart';
import 'package:todoist/responsiveLayout/TabletScaffold.dart';
import 'package:todoist/state_redux/app_state.dart';
import 'package:todoist/state_redux/reducers.dart';
import 'package:redux/redux.dart';

void main() {
  final _initialState = AppState(todos: {});
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);
  runApp(MyApp(store: _store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  const MyApp({required this.store});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Todoist',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            canvasColor: Color.fromARGB(255, 156, 156, 156),
            brightness: Brightness.dark,
            primarySwatch: Colors.amber,
            primaryColor: Colors.white,
            backgroundColor: Colors.black,
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            )),
        home: const ResponsiveScaffold(
          mobileScaffold: MobileScaffold(),
          tabletScaffold: TabletScaffold(),
          desktopScaffold: DesktopScaffold(),
        ),
      ),
    );
  }
}
