import 'package:flutter/material.dart';

class Validation {
  static String? optionalValidation(String? password, BuildContext context) {
    return null;
  }

  static String? validatePassword(String? password, BuildContext context) {
    if (password == null || password.trim().toString().length < 8) {
      return "Password must be 8 character at least";
    }
    return null;
  }

  static String? validateConfirmedPassword(
      String? password, String? confirmedPassword, BuildContext context) {
    if (confirmedPassword == null || confirmedPassword.trim().isEmpty) {
      return "Password must be 8 character at least";
    } else if (password != confirmedPassword) {
      return "Passwords doesn't matches";
    }
    return null;
  }

  static String? validateEmail(String? email, BuildContext context) {
    String pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";

    RegExp regex = RegExp(pattern);
    if (email == null || email.isEmpty || !regex.hasMatch(email)) {
      return "Please enter valid email";
    }
    return null;
  }

  static String? validateMandatoryField(String? value, context) {
    if (value == null || value.trim().isEmpty) {
      return "Mandatory field";
    }
    return null;
  }

  static bool isNumber(String text) {
    final regex = RegExp(r'(^\d+)$');
    if (regex.hasMatch(text)) {
      return true;
    }
    return false;
  }

  static String? validateUsername(String? username, BuildContext context) {
    if (username == null || username.isEmpty) {
      return "Username is required";
    }

    RegExp regex = RegExp(r'^[a-zA-Z0-9_]+$');

    if (!regex.hasMatch(username)) {
      return "Username can only contain letters, numbers, or underscores";
    }

    if (username.length < 3 || username.length > 20) {
      return "Username must be between 3 and 20 characters";
    }

    return null;
  }
}
