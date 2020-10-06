import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primaryColor: Colors.lightBlue[200],
  brightness: Brightness.light,
  accentColor: Colors.lightBlue,

  // Button
  buttonColor: Colors.lightBlue[200],
  highlightColor: Colors.yellow,
  disabledColor: Colors.grey,

  fontFamily: 'NANUMGOTHIC',
  textTheme: TextTheme(
    headline5: TextStyle(
        fontSize: 20,
        height: 1.5,
        fontWeight: FontWeight.bold,
        color: Colors.lightBlue),
    headline6: TextStyle(
        fontSize: 20,
        height: 1.5,
        fontWeight: FontWeight.bold,
        color: Colors.black),
    bodyText1: TextStyle(
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.bold,
        color: Colors.black),
    bodyText2: TextStyle(
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.bold,
        color: Colors.lightBlue),
  ),
);
