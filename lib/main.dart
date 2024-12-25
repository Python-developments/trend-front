import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trend/features/bottom_nav_bar/bnb_controller.dart';
import 'package:trend/features/home/controllers/home_controller.dart';
import 'package:trend/injection_container.dart';
import 'package:trend/utils/routes.dart';
import 'package:trend/utils/theme/dark_theme.dart';
import 'package:trend/utils/theme/light_theme.dart';
import 'package:trend/utils/theme/theme_controller.dart'; // Import your custom routes

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Get.put<HomeController>(HomeController());
  await Get.put<BnbController>(BnbController(), permanent: true);
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return Obx(() {
          return GetMaterialApp(
            themeMode: Get.find<ThemeController>().themeMode.value,
            title: 'Trend',
            theme: lightTheme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.login,
            getPages: GetPages
                .getPages, // Ensure you define this in your utils/routes.dart
            onGenerateRoute: onGenerateRoute, // Handle dynamic routing
          );
        });
      },
    );
  }
}
