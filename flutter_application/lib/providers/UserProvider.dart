import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = "";
  int i = 0;

  String get userName => _userName;

  setUserName(String name) {
    i++;
    _userName = name + i.toString();
    notifyListeners();
  }
}
