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
    String meaage = handleErrors(err.response?.data);
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/icons/close.png",
                height: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                meaage,
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          ).paddingSymmetric(horizontal: 15, vertical: 20),
          Positioned(
              right: 0,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close)))
        ],
      ),
    ));
    return _handleCachedResponse(err, handler);
  }

  String handleErrors(Map<String, dynamic> errors) {
    StringBuffer errorBuffer = StringBuffer();

    for (var entry in errors.entries) {
      String field = entry.key; // The field causing the error
      dynamic messages =
          entry.value; // The list of error messages for the field

      if (messages is List) {
        for (var message in messages) {
          errorBuffer.writeln('* $field: $message');
        }
      } else {
        // If the value is not a list, handle it gracefully
        errorBuffer.writeln('$field: $messages');
      }
    }

    return errorBuffer.toString();
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
    log(options.data.toString());
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
