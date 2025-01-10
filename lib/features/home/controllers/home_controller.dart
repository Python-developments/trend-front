import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trend/data/models/profile_model.dart';
import 'package:trend/networks/api_repository.dart';
import 'package:trend/networks/models/get_all_posts_response.dart';
import 'package:trend/utils/sharedprefrences_helper.dart';

class HomeController extends GetxController {
  ApiRepository apiRepository;
  HomeController(this.apiRepository);
  int commentIndex = -1;
  setCommentIndex(int commentIndex) {
    this.commentIndex = commentIndex;
  }

  final TextEditingController commentController = TextEditingController();

  List<Post> posts = [];
  addNewPost(Post post) {
    posts.insert(0, post);
    update();
  }

  blockUser(int userId) async {
    posts.removeWhere((e) => e.autherId == userId);
    update();
    await apiRepository.blockUser(userId);
    Get.back();
  }

  ScrollController scrollController = ScrollController();
  addListner() {
    scrollController.addListener(() {
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      final offset = scrollController.offset;
      final outOfRange = scrollController.position.outOfRange;
      if (offset >= maxScrollExtent && !outOfRange) {
        if (!isEnough) {
          getAllPosts();
        }
      }
    });
  }

  int page = 1;
  RxBool isLoading = false.obs;
  bool isEnough = false;
  getAllPosts() async {
    isLoading.value = true;
    GetAllPostsResponse getAllPostsResponse =
        await apiRepository.getPosts(page);
    isLoading.value = false;
    if ((getAllPostsResponse.results?.length ?? 0) < 10) {
      isEnough = true;
    }
    if (posts.isEmpty) {
      posts = getAllPostsResponse.results ?? [];
    } else {
      posts.addAll(getAllPostsResponse.results ?? []);
    }

    page++;
    update();
  }

  likePost(int index) {
    Post postModel = posts[index];
    postModel.likedByMe = !(postModel.likedByMe ?? false);
    if (postModel.likedByMe ?? false) {
      postModel.likesCount++;
    } else {
      postModel.likesCount--;
    }
    posts![index] = postModel;
    update();
    apiRepository.likePost(postModel.id!);
  }

  likeSubComment(int postIndex, int commentIndex, [int? subCommentIndex]) {
    Post postModel = posts![postIndex];
    late Comment commentModel;
    if (subCommentIndex == null) {
      commentModel = postModel.comments![commentIndex];
    } else {
      commentModel =
          postModel.comments![commentIndex].replies![subCommentIndex];
    }

    commentModel.likedByMe = !(commentModel.likedByMe ?? false);
    if (commentModel.likedByMe ?? false) {
      commentModel.likesCount++;
    } else {
      commentModel.likesCount--;
    }
    if (subCommentIndex == null) {
      postModel.comments![commentIndex] = commentModel;
    } else {
      postModel.comments![commentIndex].replies![subCommentIndex] =
          commentModel;
    }

    update();
    apiRepository.likeComment(commentModel.id!);
  }

  addComment(int index) async {
    if (commentController.text.trim() != "") {
      Post postModel = posts[index];
      Comment comment = await apiRepository.commentPost(
          postModel.id!, commentController.text);
      postModel.comments.add(comment);
      postModel.commentsCount++;
      update();
      commentController.clear();
    }
  }

  FocusNode commentFocusNode = FocusNode();
  focusOnReplyComment(String auther) {
    commentController.text = "@" + auther + ' ';
    commentFocusNode.requestFocus();
  }

  addCommentOnComments(int index) async {
    if (commentController.text.trim() != "") {
      Post post = posts[index];
      int postId = post.id ?? 0;
      Comment comment = post.comments[commentIndex];
      int commentId = comment.id ?? 0;

      Comment commentModel = await apiRepository.commentComment(
          postId: postId,
          commentId: commentId,
          comment: commentController.text);

      posts[index].comments[commentIndex].replies?.add(commentModel);
      commentController.clear();
      update();
    }
  }

  deleteMyComent(int postIndex, int commentIndex, int postId, int commentId) {
    posts[postIndex].comments.removeAt(commentIndex);
    update();
    apiRepository.deleteComment(postId, commentId);
  }

  deletePost(int index, int id) async {
    posts.removeAt(index);
    update();
    await apiRepository.deletePost(id);
  }

  List<Post>? userPosts;
  getUserPosts(int userId) async {
    GetAllPostsResponse response = await apiRepository.getUserPosts(userId);
    userPosts = response.results;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllPosts();
    addListner();
  }
}
