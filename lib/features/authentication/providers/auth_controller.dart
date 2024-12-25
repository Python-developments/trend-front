import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trend/utils/routes.dart';

class AuthController extends GetxController {
  register() {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      const SnackBar(content: Text('Signing up...')),
    );
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.login);
    });
  }

  login() {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      const SnackBar(content: Text('Logging in...')),
    );
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.home);
    });
  }

  resetPassword(String email) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text('Sending code to $email...')),
    );
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.checkCode, arguments: email);
    });
  }

  changePassword() {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text('Changing Password...')),
    );
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.login);
    });
  }

  checkCode() {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text('Check code...')),
    );
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.changePassword);
    });
  }
}
