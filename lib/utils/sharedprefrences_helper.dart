import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Language { ar, en }

class SpHelper {
  final SharedPreferences sp;
  SpHelper(this.sp);

  setLanguage(Language language) {
    sp.setString('language', language == Language.ar ? 'ar' : 'en');
  }

  Language getLanguage() {
    String? x = sp.getString('language') ?? 'en';
    Language language = x == 'ar' ? Language.ar : Language.en;
    return language;
  }

  saveTheme(bool isDark) async {
    await sp.setBool("isDark", isDark);
  }

  ThemeMode getTheme() {
    bool isDark = sp.getBool('isDark') ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
