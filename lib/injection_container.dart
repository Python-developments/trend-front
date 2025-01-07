import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/features/authentication/providers/auth_controller.dart';
import 'package:trend/networks/api_client.dart';
import 'package:trend/networks/api_repository.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';
import 'package:trend/utils/theme/theme_controller.dart';

Future<void> init() async {
  await GetStorage.init();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Get.put<SpHelper>(SpHelper(sharedPreferences), permanent: true);
  initSettingsAndDio();
  Get.put<ApiRepository>(ApiRepository(Get.find()));
  Get.put<AuthController>(AuthController(Get.find()), permanent: true);

  Get.put<ThemeController>(ThemeController(Get.find())).getTheme();
}
