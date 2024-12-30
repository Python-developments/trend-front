import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Response;
import 'package:lottie/lottie.dart';
import 'package:trend/networks/api_endoints.dart';
import 'package:trend/utils/resources/assets_manager.dart';

class AppInterceptors extends Interceptor {
  final _cache = <Uri, Response>{};

  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logRequest(options);
    super.onRequest(options, handler);
    _handleCache(options, handler);
  }

  @override
  Future<dynamic> onError(DioException err, ErrorInterceptorHandler handler) {
    return _handleCachedResponse(err, handler);
  }

  @override
  Future<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);

    _cache[response.requestOptions.uri] = response;
    return Future.value(response);
  }

  // Helper Methods

  void logRequest(RequestOptions options) {
    log(options.baseUrl + options.path);
  }

  void _handleCache(RequestOptions options, RequestInterceptorHandler handler) {
    var cachedResponse = _cache[options.uri];
    if (cachedResponse != null && options.method == 'get') {
      handler.resolve(cachedResponse);
    }
  }

  void logError(DioException err) {
    log("The request that caused the error is ${err.requestOptions.path}");
    _showErrorDialog(err, "error", err.toString());
  }

  void _handleError(DioException err) {
    // if (Get.currentRoute != RoutesNames.splachPageRoute) {
    //     CustomDialougs.showCustomBottomsheet(const SignInBottomsheet());
    //   }
  }

  void _showErrorDialog(
      DioException err, String titleKey, String errorMessage) {
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.sp))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            titleKey,
            style: Get.theme.textTheme.headlineLarge!.copyWith(fontSize: 14),
          ),
          Divider(),
          Text(
            errorMessage.toString(),
            style: Get.theme.textTheme.headlineLarge!.copyWith(fontSize: 12),
          ).paddingSymmetric(horizontal: 20.sp, vertical: 10.sp),
        ],
      ),
    ));
  }

  Future<dynamic> _handleCachedResponse(
      DioException err, ErrorInterceptorHandler handler) {
    var cachedResponse = _cache[err.requestOptions.uri];
    if (cachedResponse != null) {
      return Future.value(cachedResponse);
    }
    return Future.value(err);
  }
}
