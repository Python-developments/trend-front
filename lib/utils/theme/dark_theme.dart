import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  splashColor: Colors.black,
  highlightColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.black,
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.black,
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  cardColor: Colors.black,
  dialogBackgroundColor: Colors.black,
  dividerColor: Colors.grey,
  canvasColor: Colors.black,
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.black,
    elevation: 0,
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.black,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
  ),
);
