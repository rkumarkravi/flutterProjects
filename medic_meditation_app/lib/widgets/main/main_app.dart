import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medic_meditation_app/utils/consts/image_consts.dart';
import 'package:medic_meditation_app/widgets/custom/medic_appbar.dart';
import 'package:medic_meditation_app/widgets/main/profile.dart';
import 'package:medic_meditation_app/widgets/main/sounds.dart';

import 'home.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<MainApp> {
  int _selectedIndex = 0;
  int _selectedBottomNavIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Home(),
    Sounds(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MedicAppbar(),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedBottomNavIndex,
            onTap: (int index) {
              setState(() {
                _selectedBottomNavIndex=index;
                _selectedIndex=index;
              });
            },
            backgroundColor: const Color(0xFF253334),
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(ImageConsts.BOTTOM_NAV_HOME_INACTIVE),
                  activeIcon: Image.asset(
                    ImageConsts.BOTTOM_NAV_HOME_ACTIVE,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    ImageConsts.BOTTOM_NAV_SOUNDS_INACTIVE,
                  ),
                  activeIcon: Image.asset(
                    ImageConsts.BOTTOM_NAV_SOUNDS_ACTIVE,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    ImageConsts.BOTTOM_NAV_PROFILE_INACTIVE,
                  ),
                  activeIcon: Image.asset(
                    ImageConsts.BOTTOM_NAV_PROFILE_ACTIVE,
                  ),
                  label: '')
            ]),
      ),
    );
  }
}
