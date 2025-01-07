import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trend/networks/api_repository.dart';
import 'package:trend/networks/models/login_response.dart';
import 'package:trend/utils/routes.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';

class AuthController extends GetxController {
  ApiRepository apiRepository;
  AuthController(this.apiRepository);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController loginUsernameController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  register() async {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      const SnackBar(content: Text('Signing up...')),
    );
    bool x = await apiRepository.register(
        usernameController.text,
        passwordController.text,
        password2Controller.text,
        emailController.text);
    if (x) {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  login() async {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      const SnackBar(content: Text('Logging in...')),
    );
    LoginResponse? loginResponse = await apiRepository.login(
        loginUsernameController.text, loginPasswordController.text);
    Get.find<Dio>().options.headers["Authorization"] =
        'Bearer ${loginResponse?.access}';
    Get.put<ApiRepository>(ApiRepository(Get.find()));
    if (loginResponse != null) {
      await Get.find<SpHelper>().setToken(loginResponse.access);
      await Get.find<SpHelper>().setUser(loginResponse);
      Get.offAllNamed(AppRoutes.home);
    }
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
