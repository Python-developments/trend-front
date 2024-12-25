import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trend/data/models/profile_model.dart';
import 'package:trend/features/profile/views/pages/edit_profile/edit_bio.dart';
import 'package:trend/utils/media_picker_utils.dart';
import 'package:trend/utils/toast_utils.dart';

class ProfileController extends GetxController {
  ProfileModel profileModel;
  ProfileController(this.profileModel) {
    this.avatar = profileModel.avatar;
    this.username = profileModel.username;
    this.fName = profileModel.fName;
    this.lName = profileModel.lName;
    this.email = profileModel.email;
    this.bio = profileModel.bio;
    this.phone = profileModel.phone;
    this.location = profileModel.location;
  }
  String? avatar;
  String? username;
  String? fName;
  String? lName;
  String? email;
  String? bio;
  String? phone;
  String? location;
  TextEditingController bioController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  printMessage(BuildContext context) {
    ToastUtils(context).showCustomToast(
      message: "Your Profile has been updated successfully",
      iconData: Icons.done,
    );
    Get.back();
  }

  editProfile(
      BuildContext context, String newval, ProfileEdiable profileEdiable) {
    if (profileEdiable == ProfileEdiable.bio) {
      bio = newval;
    } else if (profileEdiable == ProfileEdiable.fName) {
      fName = newval;
    } else if (profileEdiable == ProfileEdiable.lName) {
      lName = newval;
    } else if (profileEdiable == ProfileEdiable.location) {
      location = newval;
    } else if (profileEdiable == ProfileEdiable.phone) {
      phone = newval;
    }
    printMessage(context);
    update();
  }

  String? avatarFileUrl;
  Future<void> pickAvatarImage(BuildContext context) async {
    final pickedImage =
        await MediaPickerUtils().showImageSourceModalThenPick(context);
    if (pickedImage != null) {
      avatarFileUrl = pickedImage.path;
      update();
    }
  }
}
