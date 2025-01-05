import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:dio/dio.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trend/features/bottom_nav_bar/bnb_controller.dart';
import 'package:trend/features/home/controllers/home_controller.dart';
import 'package:trend/networks/api_repository.dart';
import 'package:trend/networks/models/get_all_posts_response.dart';
import 'package:trend/utils/media_picker_utils.dart';
import 'package:image/image.dart' as img;
import 'package:trend/utils/sharedprefrences_helper.dart';

class NewPostController extends GetxController {
  ApiRepository apiRepository;
  NewPostController(this.apiRepository);
  TextEditingController contentController = TextEditingController();
  File? newPostImage;
  String? avatarFileUrl;
  void _scrollToEnd() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  late double imageHeight;
  late double imageWidth;
  pickImage(BuildContext context, ImageSource imageSource) async {
    final pickedImage =
        await MediaPickerUtils().pickImage(context, imageSource);

    if (pickedImage != null) {
      avatarFileUrl = pickedImage.path;
      final img.Image image = img.decodeImage(await pickedImage.readAsBytes())!;
      imageHeight = image.height.toDouble();
      imageWidth = image.width.toDouble();
      bool changeHeigh = false;
      if (imageHeight > (1.5 * imageWidth)) {
        changeHeigh = true;
      }

      newPostImage = await cropImage(pickedImage, changeHeigh);
      update();
      await Future.delayed(Duration(milliseconds: 200));
      _scrollToEnd();
    }
  }

  ScrollController scrollController = ScrollController();
  void scrollToEnd() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  Future<File> cropImage(XFile pickedFile, [bool changeHeigh = false]) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
          ],
        ),
        IOSUiSettings(
            title: 'Cropper',
            cropStyle: CropStyle.rectangle,
            aspectRatioLockEnabled: true,
            rectX: 1,
            rectY: changeHeigh ? 1.5 : null, // can be null
            rectWidth: Get.width,
            rectHeight: Get.width * 1.5,
            aspectRatioLockDimensionSwapEnabled: true,
            aspectRatioPickerButtonHidden: false,
            resetAspectRatioEnabled: false,
            rotateClockwiseButtonHidden: false,
            rotateButtonsHidden: true,
            resetButtonHidden: true,
            cancelButtonTitle: ""
            // minimumAspectRatio: 100,
            ),
      ],
    );
    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return File(pickedFile.path);
  }

  RxBool isLoading = false.obs;
  addNewPost() async {
    isLoading.value = true;
    MultipartFile multipartFile =
        await MultipartFile.fromFile(newPostImage!.path);
    Post post = await apiRepository.createPost(
        contentController.text,
        Get.find<SpHelper>().getUser()?.userInfo?.username ?? '',
        imageHeight,
        imageWidth,
        multipartFile);
    log(post.toJson().toString());
    isLoading.value = false;
    newPostImage = null;
    contentController.clear();
    Get.find<HomeController>().addNewPost(post);
    Get.find<BnbController>().delectedIndex.value = 0;
  }
}
