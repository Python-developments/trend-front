import 'dart:io';

import 'package:trend/networks/models/get_all_users_response.dart';

class GetAllPostsResponse {
  int? count;
  List<Post>? results;

  GetAllPostsResponse({this.count, this.results});

  GetAllPostsResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['results'] != null) {
      results = <Post>[];
      json['results'].forEach((v) {
        results!.add(new Post.fromJson(v));
      });
    }
  }
}

class Post {
  int? id;
  int? autherId;
  String? author;
  String? authorAvatar;
  String? description;
  String? image;
  File? file;
  late DateTime createdAt;
  late DateTime updatedAt;
  late int likesCount;
  late int commentsCount;
  late int sharesCount;
  late int viewsCount;
  bool? isPublic;
  bool? allowComments;
  bool? likedByMe;
  late List<Comment> comments;
  late List<LikedUsers> likedUsers;
  late List<AppUser> taggedUsers;

  Post(
      {this.id,
      this.author,
      this.authorAvatar,
      this.description,
      this.image,
      this.file,
      required this.createdAt,
      required this.updatedAt,
      this.likesCount = 0,
      this.commentsCount = 0,
      this.sharesCount = 0,
      this.viewsCount = 0,
      this.isPublic,
      this.allowComments,
      this.likedByMe,
      this.comments = const [],
      this.likedUsers = const [],
      this.taggedUsers = const []});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    autherId = json['author_id'];
    author = json['author'];
    description = json['description'];
    image = json['image'];
    createdAt = DateTime.parse(json['created_at'] ?? '');
    updatedAt = DateTime.parse(json['updated_at'] ?? '');

    likesCount = json['likes_count'] ?? 0;
    likedByMe = json['is_liked'] ?? false;
    commentsCount = json['comments_count'] ?? 0;
    sharesCount = json['shares_count'] ?? 0;
    viewsCount = json['views_count'] ?? 0;
    isPublic = json['is_public'];
    allowComments = json['allow_comments'];
    if (json['comments'] != null) {
      comments = <Comment>[];
      json['comments'].forEach((v) {
        comments.add(new Comment.fromJson(v));
      });
    }
    if (json['liked_users'] != null) {
      likedUsers = <LikedUsers>[];
      json['liked_users'].forEach((v) {
        likedUsers.add(new LikedUsers.fromJson(v));
      });
    }
    if (json['tagged_users'] != null) {
      taggedUsers = <AppUser>[];
      json['tagged_users'].forEach((v) {
        taggedUsers.add(AppUser.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['author_id'] = this.autherId;
    data['description'] = this.description;
    data['image'] = this.image;
    data['is_liked'] = this.likedByMe;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['likes_count'] = this.likesCount;
    data['comments_count'] = this.commentsCount;
    data['shares_count'] = this.sharesCount;
    data['views_count'] = this.viewsCount;
    data['is_public'] = this.isPublic;
    data['allow_comments'] = this.allowComments;

    return data;
  }
}

class Comment {
  int? id;
  int? autherId;
  int? post;
  String? author;
  String? content;
  String? createdAt;
  String? updatedAt;
  late int likesCount;
  int? repliesCount;
  List<LikedUsers>? likedUsers;

  bool? likedByMe;
  List<Comment>? replies;

  Comment(
      {this.id,
      this.post,
      this.author,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.likesCount = 0,
      this.repliesCount,
      this.likedUsers,
      this.likedByMe,
      this.replies});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    autherId = json['author_id'];
    likedByMe = json['is_liked'];
    post = json['post'];
    author = json['author'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likesCount = json['likes_count'];
    repliesCount = json['replies_count'];
    if (json['liked_users'] != null) {
      likedUsers = <LikedUsers>[];
      json['liked_users'].forEach((v) {
        likedUsers!.add(new LikedUsers.fromJson(v));
      });
    }
    replies = <Comment>[];
    if (json['replies'] != null) {
      json['replies'].forEach((v) {
        replies?.add(new Comment.fromJson(v));
      });
    }
  }
}

class LikedUsers {
  int? id;
  String? username;

  LikedUsers({this.id, this.username});

  LikedUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}
