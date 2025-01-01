import 'dart:io';
import 'package:trend/data/models/profile_model.dart';

class PostModel {
  File? file;
  String image;
  String content;
  String createdAt;
  bool likedByMe;
  int likeCounts;
  int commentsCounts;
  List<String> tags;
  List<CommentModel> comments;
  ProfileModel profileModel;
  String locationName;

  PostModel(
      {this.file,
      required this.image,
      required this.content,
      required this.createdAt,
      required this.profileModel,
      required this.locationName,
      this.likedByMe = false,
      this.comments = const [],
      this.tags = const [],
      this.commentsCounts = 0,
      this.likeCounts = 0});
}

class CommentModel {
  String comment;
  bool likedByMe;
  int likeCounts;
  int? commentsCounts;
  ProfileModel authorProfile;
  bool showMore;
  List<CommentModel> comments = [];
  CommentModel(this.comment, this.authorProfile, this.likeCounts,
      [this.likedByMe = false, this.showMore = false]);
}
