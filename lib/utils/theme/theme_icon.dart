import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trend/utils/theme/theme_controller.dart';

class ThemeIcon extends StatelessWidget {
  const ThemeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Get.find<ThemeController>().changeTheme();
      },
      child: Obx(() {
        return Get.find<ThemeController>().themeMode.value == ThemeMode.light
            ? LottieBuilder.asset('/assets/lotties/moon.json')
            : LottieBuilder.asset('/assets/lotties/sun.json');
      }),
    );
  }
}
