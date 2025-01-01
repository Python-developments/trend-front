import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trend/data/models/post_model.dart';
import 'package:trend/data/models/profile_model.dart';

class HomeController extends GetxController {
  addNewPost(PostModel post) {
    posts.insert(0, post);
    update();
  }

  final TextEditingController commentController = TextEditingController();

  List<PostModel> posts = [
    PostModel(
        locationName: "",
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        commentsCounts: 2,
        likeCounts: 5,
        likedByMe: true,
        comments: [
          CommentModel(
              "This is fake comment 1",
              ProfileModel(
                  username: "fake user 1",
                  email: "fake user 1@gmail.com",
                  bio: "This is bio from posts"),
              0),
          CommentModel(
              "This is fake comment 2",
              ProfileModel(
                  username: "fake user 2",
                  email: "fake user 2@gmail.com",
                  bio: "This is bio from posts"),
              0)
        ],
        profileModel: ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts")),
    PostModel(
        locationName: "",
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        profileModel: ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts")),
    PostModel(
        locationName: "",
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        profileModel: ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts")),
    PostModel(
        locationName: "",
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        profileModel: ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts"))
  ];
  likePost(int index) {
    PostModel postModel = posts[index];
    postModel.likedByMe = !postModel.likedByMe;
    if (postModel.likedByMe) {
      postModel.likeCounts++;
    } else {
      postModel.likeCounts--;
    }
    posts[index] = postModel;
    update();
  }

  likeSubComment(int postIndex, int commentIndex, [int? subCommentIndex]) {
    PostModel postModel = posts[postIndex];
    late CommentModel commentModel;
    if (subCommentIndex == null) {
      commentModel = postModel.comments[commentIndex];
    } else {
      commentModel = postModel.comments[commentIndex].comments[subCommentIndex];
    }

    commentModel.likedByMe = !commentModel.likedByMe;
    if (commentModel.likedByMe) {
      commentModel.likeCounts++;
    } else {
      commentModel.likeCounts--;
    }
    if (subCommentIndex == null) {
      postModel.comments[commentIndex] = commentModel;
    } else {
      postModel.comments[commentIndex].comments[subCommentIndex] = commentModel;
    }

    update();
  }

  addComment(int index) {
    PostModel postModel = posts[index];
    postModel.comments.add(CommentModel(
        commentController.text,
        ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts"),
        0));
    postModel.commentsCounts++;
    commentController.clear();
    update();
  }

  FocusNode commentFocusNode = FocusNode();
  focusOnReplyComment(ProfileModel profile_model) {
    commentController.text = "@" + profile_model.username + ' ';
    commentFocusNode.requestFocus();
  }

  addCommentOnComments(int index, int commentIndex) {
    CommentModel commentModel = CommentModel(
        commentController.text.substring(commentController.text.indexOf(" ")),
        ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts"),
        0);
    posts[index].comments[commentIndex].comments.add(commentModel);
    commentController.clear();
    update();
  }
}
