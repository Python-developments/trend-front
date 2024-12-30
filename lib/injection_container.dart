import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/features/authentication/providers/auth_controller.dart';
import 'package:trend/networks/api_client.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';
import 'package:trend/utils/theme/theme_controller.dart';

Future<void> init() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  initSettingsAndDio();
  Get.put<SharedPreferences>(sharedPreferences);
  Get.lazyPut<AuthController>(() => AuthController());
  Get.put<SpHelper>(SpHelper(sharedPreferences));
  Get.put<ThemeController>(ThemeController(Get.find())).getTheme();
}
