import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.light,
  ),
  cardTheme: const CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  ),
  listTileTheme: const ListTileThemeData(
    enableFeedback: true,
    contentPadding: EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    titleTextStyle: TextStyle(fontWeight: FontWeight.w600),
    leadingAndTrailingTextStyle: TextStyle(fontSize: 24),
  ),
  splashColor: Colors.white,
  highlightColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.white,
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  cardColor: Colors.white,
  dialogBackgroundColor: Colors.white,
  dividerColor: Colors.grey,
  canvasColor: Colors.white,
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.white,
    elevation: 0,
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
  ),
);
