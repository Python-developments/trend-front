import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:trend/data/models/post_model.dart';
import 'package:trend/data/models/profile_model.dart';
import 'package:trend/features/bottom_nav_bar/bnb_controller.dart';
import 'package:trend/features/home/controllers/home_controller.dart';
import 'package:trend/utils/media_picker_utils.dart';
import 'package:image/image.dart' as img;

class NewPostController extends GetxController {
  TextEditingController contentController = TextEditingController();
  File? newPostImage;
  String? avatarFileUrl;
  pickImage(BuildContext context, ImageSource imageSource) async {
    final pickedImage =
        await MediaPickerUtils().pickImage(context, imageSource);

    if (pickedImage != null) {
      avatarFileUrl = pickedImage.path;
      final img.Image image = img.decodeImage(await pickedImage.readAsBytes())!;
      double imageHeight = image.height.toDouble();
      double imageWidth = image.width.toDouble();
      bool changeHeigh = false;
      if (imageHeight > (1.5 * imageWidth)) {
        changeHeigh = true;
      }

      newPostImage = await cropImage(pickedImage, changeHeigh);
      update();
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

  addNewPost() {
    Get.find<HomeController>().addNewPost(
      PostModel(
          locationName: "",
          file: newPostImage,
          image:
              "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          content: contentController.text,
          createdAt: "15 5 1987",
          profileModel: ProfileModel(
              username: "username",
              email: "email@gmail.com",
              bio: "This is bio from posts")),
    );
    newPostImage = null;
    contentController.clear();
    update();
    Get.find<BnbController>().delectedIndex.value = 0;
  }
}
