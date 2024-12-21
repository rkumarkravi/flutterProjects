import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ThemeProvider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: SafeArea(
        child: Column(children: [ChooseTheme(themeProvider: themeProvider)]),
      ),
    );
  }
}

class ChooseTheme extends StatelessWidget {
  const ChooseTheme({super.key, required this.themeProvider});

  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text('Choose Theme:', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 16),
        ToggleButtons(
          isSelected: [
            themeProvider.themeMode == ThemeMode.light,
            themeProvider.themeMode == ThemeMode.dark,
            themeProvider.themeMode == ThemeMode.system,
          ],
          onPressed: (int index) {
            ThemeMode selectedMode;
            switch (index) {
              case 0:
                selectedMode = ThemeMode.light;
                break;
              case 1:
                selectedMode = ThemeMode.dark;
                break;
              case 2:
              default:
                selectedMode = ThemeMode.system;
                break;
            }
            themeProvider.toggleTheme(selectedMode);
          },
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Light'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Dark'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('System'),
            ),
          ],
        ),
      ],
    );
  }
}
