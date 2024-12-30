import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:trend/networks/api_interceptor.dart';

initSettingsAndDio() async {
  var dio = Dio()
    ..interceptors.add(AppInterceptors())
    ..options.followRedirects = false
    ..options.validateStatus = (status) {
      return status! < 300;
    };
  Get.put<Dio>(dio);
}
