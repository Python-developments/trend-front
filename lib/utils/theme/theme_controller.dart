import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';

class ThemeController extends GetxController {
  final SpHelper spHelper;
  ThemeController(this.spHelper);
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  changeTheme() {
    themeMode.value =
        themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    update();

    bool isDark = themeMode.value == ThemeMode.dark ? true : false;
    spHelper.saveTheme(isDark);
  }

  getTheme() {
    themeMode.value = spHelper.getTheme();
  }
}
