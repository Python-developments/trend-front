import 'package:dio/dio.dart';
import 'package:trend/networks/api_endoints.dart';

class ApiRepository {
  Dio dio;
  ApiRepository(this.dio);
  login(String userName, String password) async {
    dio.post(ApiEndPoints.login,
        data: {"username": userName, "password": password});
  }

  register(
      String userName, String password1, String password2, String email) async {
    dio.post(ApiEndPoints.register, data: {
      "username": userName,
      "password1": password1,
      "password2": password2,
      "email": email
    });
  }

  changePassword(
      String oldPassword, String newPasword, String password2) async {
    dio.post(ApiEndPoints.changePassword, data: {
      "old_password": oldPassword,
      "new_password": newPasword,
      "confirm_password": password2
    });
  }

  resetPasswprd(String email) async {
    dio.post(ApiEndPoints.resetPassword, data: {"email": email});
  }

  confirmResetPassword(String uid, String token, String newPassword) async {
    dio.post(ApiEndPoints.confirmResetPassword,
        data: {"uid": uid, "token": token, "new_password": newPassword});
  }

  refreshToken(String userName, String password) async {
    dio.post(ApiEndPoints.login,
        data: {"username": userName, "password": password});
  }

  blockList(String userName, String password) async {
    dio.post(ApiEndPoints.login,
        data: {"username": userName, "password": password});
  }

  getAllUsers(String userName, String password) async {
    dio.post(ApiEndPoints.login,
        data: {"username": userName, "password": password});
  }

  //////////////////////////////////////////////////////
  editProfile(String fullName, String bio, String location, String birthData,
      bool is_private) async {
    dio.post(ApiEndPoints.login, data: {
      "full_name": fullName,
      "bio": bio,
      "location": location,
      "birth_date": birthData,
      "is_private": is_private
    });
  }

  getProfile(int id) async {
    dio.post(
      ApiEndPoints.getProfile(id),
    );
  }

  followUser(int id) async {
    dio.post(ApiEndPoints.followUser(id));
  }

  unFollowUser(int id) async {
    dio.post(ApiEndPoints.unFollowUser(id));
  }

  blockUser(int id) async {
    dio.post(ApiEndPoints.login);
  }

  displayBlockById(int id) async {
    dio.post(ApiEndPoints.login);
  }

//////////////////////////////////////////////////////////////////
  getPosts() async {
    dio.post(ApiEndPoints.postsPrefix);
  }

  createPost(String content, String userName, double height, double width,
      MultipartFile file) async {
    dio.post(ApiEndPoints.createPost, data: {
      "image": file,
      "content": content,
      "height": height,
      "width": width,
      "username": userName
    });
  }

  likePost(int id) async {
    dio.post(ApiEndPoints.likePost(id));
  }

  commentPost(int id, String comment) async {
    dio.post(ApiEndPoints.commentPost(id),
        data: {"post": id, "content": comment});
  }

  likeComment(int id) async {
    dio.post(ApiEndPoints.likeComment(id));
  }
}
