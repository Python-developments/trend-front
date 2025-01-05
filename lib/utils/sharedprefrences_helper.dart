import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/networks/models/login_response.dart';

enum Language { ar, en }

class SpHelper {
  final SharedPreferences sp;
  SpHelper(this.sp);

  setToken(String? token) {
    if (token != null) {
      sp.setString("token", token);
    }
  }

  String? getToken() {
    return sp.getString("token");
  }

  setUser(LoginResponse user) {
    sp.setString("user", json.encode(user.toJson()));
  }

  LoginResponse? getUser() {
    String? user = sp.getString("user");
    if (user != null) {
      return LoginResponse.fromJson(json.decode(user));
    }
    return null;
  }

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
