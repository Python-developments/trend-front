import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trend/data/models/post_model.dart';
import 'package:trend/data/models/profile_model.dart';
import 'package:trend/networks/api_repository.dart';
import 'package:trend/networks/models/get_all_posts_response.dart';

class ExploreController extends GetxController {
  ApiRepository apiRepository;
  ExploreController(this.apiRepository);
  String tag = "";
  PageController pageController = PageController();
  List<Post> posts = [];
  getAllPosts() async {
    GetAllPostsResponse getAllPostsResponse = await apiRepository.getAllPosts();
    posts = getAllPostsResponse.results ?? [];
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllPosts();
  }
}
