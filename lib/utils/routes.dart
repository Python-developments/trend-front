import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:trend/features/authentication/pages/check_code_page.dart';
import 'package:trend/features/authentication/pages/confirm_forget_password_page.dart';
import 'package:trend/features/authentication/pages/login.dart';
import 'package:trend/features/authentication/pages/reset_password.dart';
import 'package:trend/features/authentication/pages/signup.dart';
import 'package:trend/features/home/home_page.dart';
import 'package:trend/features/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:trend/features/profile/views/pages/block_page/block.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String resetPassword = '/reset-password';
  static const String checkCode = '/check-code';
  static const String changePassword = '/change-password';
  static const String blockpage = '/block';
}

class GetPages {
  static List<GetPage<dynamic>>? getPages = [
    GetPage(name: '/home', page: () => MainScreen()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/signup', page: () => SignupPage()),
    GetPage(name: '/reset-password', page: () => ResetPasswordPage()),
    GetPage(name: '/check-code', page: () => CheckCodePage()),
    GetPage(name: '/change-password', page: () => ConfirmForgetPasswordPage()),
    GetPage(name: '/block', page: () => BlockedUsers()),
  ];
}

Map<String, WidgetBuilder> routes = {
  AppRoutes.login: (context) => LoginPage(),
  AppRoutes.signup: (context) => SignupPage(),
  AppRoutes.resetPassword: (context) => ResetPasswordPage(),
  AppRoutes.home: (context) => MainScreen(),
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.resetPassword:
      return MaterialPageRoute(builder: (_) => ResetPasswordPage());
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => LoginPage());
    case AppRoutes.signup:
      return MaterialPageRoute(builder: (_) => SignupPage());
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => HomePage());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('404: Page not found'),
          ),
        ),
      );
  }
}
