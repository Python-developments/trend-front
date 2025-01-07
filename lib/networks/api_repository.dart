import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import 'package:trend/features/profile/controller/profile_controller.dart';
import 'package:trend/networks/api_endoints.dart';
import 'package:trend/networks/models/get_all_posts_response.dart';
import 'package:trend/networks/models/get_all_users_response.dart';
import 'package:trend/networks/models/get_profie_Response.dart';
import 'package:trend/networks/models/login_response.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';

class ApiRepository {
  Dio dio;
  ApiRepository(this.dio);
  Future<LoginResponse?> login(String userName, String password) async {
    Response response = await dio.post(ApiEndPoints.login,
        data: {"username": userName, "password": password});

    return LoginResponse.fromJson(response.data);
  }

  Future<bool> register(
      String userName, String password1, String password2, String email) async {
    log("register request riggered");
    Response response = await dio.post(ApiEndPoints.register, data: {
      "username": userName,
      "password": password1,
      "password_confirm": password2,
      "email": email
    });
    log(response.data.toString());
    return true;
  }

  changePassword(
      String oldPassword, String newPasword, String password2) async {
    Response response = await dio.post(ApiEndPoints.changePassword, data: {
      "old_password": oldPassword,
      "new_password": newPasword,
      "confirm_password": password2
    });
  }

  Future<bool> resetPasswprd(String email) async {
    Response response =
        await dio.post(ApiEndPoints.resetPassword, data: {"email": email});
    return true;
  }

  confirmResetPassword(String uid, String token, String newPassword) async {
    Response response = await dio.post(ApiEndPoints.confirmResetPassword,
        data: {"uid": uid, "token": token, "new_password": newPassword});
  }

  refreshToken(String userName, String password) async {
    Response response = await dio.post(ApiEndPoints.login,
        data: {"username": userName, "password": password});
  }

  Future<List<GetProfileResponse>> blockList() async {
    Response response = await dio.get(
      ApiEndPoints.blockList,
    );
    return (response.data['results'] as List).map((e) {
      return GetProfileResponse.fromJson(e);
    }).toList();
  }

  Future<GetAllUsersResponse> getAllUsers(
      String userName, String password) async {
    Response response = await dio.post(ApiEndPoints.login,
        data: {"username": userName, "password": password});
    return GetAllUsersResponse.fromJson(response.data);
  }

  //////////////////////////////////////////////////////
  Future<GetProfileResponse> editProfile(Map<String, dynamic> data) async {
    Response response = await dio.put(
        ApiEndPoints.getProfile(
            Get.find<SpHelper>().getUser()?.userInfo?.id ?? 0),
        data: data);
    return GetProfileResponse.fromJson(response.data);
  }

  Future<GetProfileResponse> getProfile(int id) async {
    Response response = await dio.get(
      ApiEndPoints.getProfile(id),
    );
    return GetProfileResponse.fromJson(response.data);
  }

  Future<String?> followUser(int id) async {
    Response response = await dio.post(ApiEndPoints.followUser(id));
    return response.data["details"];
  }

  Future<String?> unFollowUser(int id) async {
    Response response = await dio.post(ApiEndPoints.unFollowUser(id));
    return response.data["details"];
  }

  Future<List<GetProfileResponse>> getFollowers(int userId) async {
    Response response = await dio.get(ApiEndPoints.getFollowers(userId));
    return (response.data['results'] as List).map((e) {
      return GetProfileResponse.fromJson(e);
    }).toList();
  }

  Future<List<GetProfileResponse>> getFollowing(int userId) async {
    Response response = await dio.get(ApiEndPoints.getFollowings(userId));
    return (response.data['results'] as List).map((e) {
      return GetProfileResponse.fromJson(e);
    }).toList();
  }

  Future<bool> blockUser(int id) async {
    await dio.post(ApiEndPoints.blockUser(id));
    return true;
  }

  Future<bool> unblockUser(int id) async {
    await dio.post(ApiEndPoints.unblockUser(id));
    return true;
  }

  Future<List<GetProfileResponse>> displayBlockList() async {
    Response response = await dio.post(ApiEndPoints.blockList);
    return (response.data['results'] as List).map((e) {
      return GetProfileResponse.fromJson(e);
    }).toList();
  }

//////////////////////////////////////////////////////////////////
  Future<GetAllPostsResponse> getPosts([int page = 1]) async {
    Response response = await dio
        .get(ApiEndPoints.postsPrefix, queryParameters: {"page": page});
    log(response.data.toString());
    return GetAllPostsResponse.fromJson(response.data);
  }

  Future<Post> createPost(String content, String userName, double height,
      double width, MultipartFile file) async {
    Response response = await dio.post(ApiEndPoints.createPost,
        data: FormData.fromMap(
            {"image": file, "description": content, "username": userName}));
    return Post.fromJson(response.data);
  }

  Future<bool> likePost(int id) async {
    await dio.post(ApiEndPoints.likePost(id));
    return true;
  }

  Future<bool> commentPost(int id, String comment) async {
    await dio.post(ApiEndPoints.commentPost(id),
        data: {"post": id, "content": comment});
    return true;
  }

  Future<bool> commentComment(
      {required int postId,
      required int commentId,
      required String comment}) async {
    await dio.post(ApiEndPoints.addCommentOnComment(commentId),
        data: {"post": postId, "content": comment});
    return true;
  }

  Future<bool> likeComment(int id) async {
    await dio.post(ApiEndPoints.likeComment(id));
    return true;
  }

  Future<bool> deletePost(int id) async {
    await dio.delete(ApiEndPoints.getPost(id));
    return true;
  }

  Future<GetAllPostsResponse> getUserPosts(int userId) async {
    Response response = await dio.get(ApiEndPoints.getUserPosts(userId));
    return GetAllPostsResponse.fromJson(response.data);
  }
}
