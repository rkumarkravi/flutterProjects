import 'package:flutter/material.dart';

class CustomInputDecorationTheme {
        CustomInputDecorationTheme._();

        static const inputDecorationTheme=InputDecorationTheme(
          // border: UnderlineInputBorder(
          //   borderRadius: BorderRadius.circular(10.0),
          // ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            // borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0),
            // borderRadius: BorderRadius.circular(10.0),
          ),
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Color(0xFFBEC2C2)),
        );
}