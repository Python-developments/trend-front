import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trend/utils/routes.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';

class SplachScreen extends StatefulWidget {
  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  NavigationFromSplach() {
    Future.delayed(Duration(seconds: 3)).then((v) {
      if (Get.find<SpHelper>().getToken() != null) {
        Get.offNamed(AppRoutes.home);
      } else {
        Get.offNamed(AppRoutes.login);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NavigationFromSplach();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
          child: Text(
        "T R E N D",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      )),
    );
  }
}
