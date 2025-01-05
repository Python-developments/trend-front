import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trend/data/models/profile_model.dart';
import 'package:trend/features/profile/views/pages/edit_profile/edit_bio.dart';
import 'package:trend/networks/api_repository.dart';
import 'package:trend/networks/models/get_all_posts_response.dart';
import 'package:trend/networks/models/get_profie_Response.dart';
import 'package:trend/utils/media_picker_utils.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';
import 'package:trend/utils/toast_utils.dart';

class ProfileController extends GetxController {
  ApiRepository apiRepository;
  int? id;
  ProfileController(this.apiRepository, [this.id]);
  String? avatar;
  String? username;
  String? fName;
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

  RxBool isLoading = false.obs;
  editProfile(BuildContext context, String newval,
      ProfileEdiable profileEdiable) async {
    if (profileEdiable == ProfileEdiable.bio) {
      bio = newval;
    } else if (profileEdiable == ProfileEdiable.fullName) {
      fName = newval;
    }
    Map<String, dynamic>? data = profileEdiable == ProfileEdiable.bio
        ? {
            "bio": bio,
          }
        : profileEdiable == ProfileEdiable.fullName
            ? {
                "full_name": fName,
              }
            : null;
    if (data != null) {
      isLoading.value = true;
      await apiRepository.editProfile(data);
      isLoading.value = false;
    }
    Get.back();
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

  GetProfileResponse? profileModel;
  getProfileById([int? id, bool getData = true]) async {
    if (id != null) {
      GetProfileResponse getProfileResponse =
          await apiRepository.getProfile(id);

      profileModel = getProfileResponse;

      update();
      if (getData) {
        getUserPosts(id);
        getBlockList(id);
      }

      getUserFollowers(id);
      getUserFolowings(id);
    }
  }

  List<Post>? userPosts;
  List<GetProfileResponse>? followingUsers;
  List<GetProfileResponse>? followersUsers;
  List<GetProfileResponse>? block;
  followUser(int id) async {
    loadingFollow.value = true;
    await apiRepository.followUser(id);
    await getProfileById(id, false);
    loadingFollow.value = false;
  }

  RxBool loadingFollow = false.obs;
  unFollowUser(int id) async {
    loadingFollow.value = true;
    await apiRepository.unFollowUser(id);
    await getProfileById(id, false);
    loadingFollow.value = false;
  }

  getUserPosts(int userId) async {
    GetAllPostsResponse response = await apiRepository.getUserPosts(userId);
    userPosts = response.results;
    update();
  }

  getUserFollowers(int userId) async {
    followersUsers = await apiRepository.getFollowers(userId);
    update();
  }

  getUserFolowings(int userId) async {
    followingUsers = await apiRepository.getFollowing(userId);
    update();
  }

  getBlockList(int userId) async {
    block = await apiRepository.blockList();
    update();
  }

  unBlockUser(int userId) async {
    block?.removeWhere((e) => e.id == userId);
    update();
    await apiRepository.unblockUser(userId);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfileById(id);
  }
}
