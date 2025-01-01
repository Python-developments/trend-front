import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trend/data/models/post_model.dart';
import 'package:trend/data/models/profile_model.dart';

class ExploreController extends GetxController {
  String tag = "";
  PageController pageController = PageController();
  List<PostModel> posts = [
    PostModel(
        locationName: "Egypt, Cairo",
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        commentsCounts: 2,
        likeCounts: 5,
        likedByMe: true,
        tags: ["football", "sport", "arabic"],
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
        locationName: "Egypt, Cairo",
        tags: ["football", "sport2", "arabic2"],
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        profileModel: ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts")),
    PostModel(
        locationName: "Qatar, Doha",
        tags: ["football", "sport3", "arabic3"],
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        profileModel: ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts")),
    PostModel(
        locationName: "Egypt, Cairo",
        tags: ["football", "sport4", "arabic4"],
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        profileModel: ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts")),
    PostModel(
        locationName: "Qatar, Doha",
        tags: ["football", "sport", "arabic5"],
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        profileModel: ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts")),
    PostModel(
        locationName: "Qatar, Doha",
        tags: ["football", "sport", "arabic6"],
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        profileModel: ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts")),
    PostModel(
        locationName: "Qatar, Doha",
        tags: ["football7", "sport", "arabic"],
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        profileModel: ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts")),
    PostModel(
        locationName: "Palestine, Gaza",
        tags: ["football8", "sport", "arabic"],
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        profileModel: ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts")),
    PostModel(
        locationName: "Palestine, Gaza",
        tags: ["football9", "sport", "arabic"],
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        profileModel: ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts")),
    PostModel(
        locationName: "Palestine, Gaza",
        tags: ["football11", "sport", "arabic"],
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        profileModel: ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts")),
    PostModel(
        locationName: "Palestine, Gaza",
        tags: ["football12", "sport", "arabic"],
        image:
            "https://images.unsplash.com/photo-1421789665209-c9b2a435e3dc?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content: "Sample Content For Post",
        createdAt: "15 5 1987",
        profileModel: ProfileModel(
            username: "username",
            email: "email@gmail.com",
            bio: "This is bio from posts"))
  ];
}
