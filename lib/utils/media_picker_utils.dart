// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trend/utils/resources/assets_manager.dart';
import 'package:trend/utils/toast_utils.dart';
import 'package:video_player/video_player.dart';

class MediaPickerUtils {
  factory MediaPickerUtils() {
    return _instance;
  }
  const MediaPickerUtils._();

  static const MediaPickerUtils _instance = MediaPickerUtils._();

  Future<File?> pickVideo(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      final videoFile = File(pickedFile.path);
      final videoPlayerController = VideoPlayerController.file(videoFile);

      try {
        await videoPlayerController.initialize();

        final duration = videoPlayerController.value.duration;
        if (duration <= const Duration(seconds: 15)) {
          return videoFile;
        } else {
          ToastUtils(context)
              .showCustomToast(message: 'Selected video exceeds 15 seconds');

          return null;
        }
      } catch (e) {
        debugPrint('Error initializing video player: $e');
        return null;
      } finally {
        videoPlayerController.dispose();
      }
    }

    return null;
  }

  Future<XFile?> pickImage(BuildContext context,
      [ImageSource source = ImageSource.gallery]) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1200,
        imageQuality: 80,
      );

      if (image != null) {
        return XFile(image.path);
      }
      return null;
    } catch (e) {
      debugPrint('Exception ==> $e');
      await _checkPermission(context, e);
    }
    return null;
  }

  Future<List<XFile>?> pickMultiImages(BuildContext context) async {
    try {
      final picker = ImagePicker();
      List<XFile>? pickedFiles = await picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1200,
        imageQuality: 80,
      );

      if (pickedFiles.isNotEmpty) {
        if (pickedFiles.length <= 20) {
          return pickedFiles;
        } else {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("To many images selected"),
                content: Text("Please do not select more than 20 images"),
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      debugPrint('Exception ==> $e');
      await _checkPermission(context, e);
    }
    return null;
  }

  Future<XFile?> showImageSourceModalThenPick(BuildContext context) async {
    return showModalBottomSheet<XFile>(
      backgroundColor: Colors.white,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(100.sp),
          topLeft: Radius.circular(100.sp),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(bottom: 50, top: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.sp),
              topLeft: Radius.circular(16.sp),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 15.sp),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10.sp)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 8.sp),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: Transform.scale(
                    scale: 1.2.sp,
                    child: SvgPicture.asset(
                      ImgAssets.addIconSVG,
                      width: 13.sp,
                      height: 13.sp,
                      color: Colors.black,
                    ),
                  ),
                  title: Text(
                    'Take a photo',
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                  onTap: () async {
                    final file =
                        await _pickImageFromSource(context, ImageSource.camera);
                    Navigator.pop(context, file);
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Divider(
                    height: 0.5,
                    thickness: 0.5,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: SvgPicture.asset(
                    ImgAssets.gallery2IconSVG,
                    width: 13.sp,
                    height: 13.sp,
                    color: Colors.black,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).textTheme.displayLarge!.color!,
                        BlendMode.srcIn),
                  ),
                  title: Text(
                    'Choose from gallery',
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                  onTap: () async {
                    final file = await _pickImageFromSource(
                        context, ImageSource.gallery);
                    Navigator.pop(context, file);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<XFile?> _pickImageFromSource(
      BuildContext context, ImageSource source) async {
    return pickImage(context, source);
  }

  Future<void> _showAlertPermissionsDialog(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Permissions Denied'),
          content: Text('Allow access to gallery and photos'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: openAppSettings,
              child: Text('Settings'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkPermission(BuildContext context, Object e) async {
    if (Platform.isIOS) {
      final permissionStatus = (await Permission.photos.status);

      if (permissionStatus.isDenied) {
        // show dialog
        await _showAlertPermissionsDialog(context);
      } else {
        debugPrint('Image Exception ==> $e');
      }
    }
  }
}
