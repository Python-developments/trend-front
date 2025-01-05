import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:trend/networks/api_interceptor.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';

initSettingsAndDio() async {
  var dio = Dio()
    ..options.baseUrl = "http://167.71.92.176"
    ..interceptors.add(AppInterceptors())
    ..options.followRedirects = false
    ..options.headers = {
      "Authorization": "Bearer ${Get.find<SpHelper>().getToken()}"
    }
    ..options.validateStatus = (status) {
      return status! < 300;
    };
  Get.put<Dio>(dio);
}
