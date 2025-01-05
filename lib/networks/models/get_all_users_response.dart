class GetAllUsersResponse {
  int? count;
  List<AppUser>? results;

  GetAllUsersResponse({this.count, this.results});

  GetAllUsersResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];

    if (json['results'] != null) {
      results = <AppUser>[];
      json['results'].forEach((v) {
        results!.add(new AppUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppUser {
  int? id;
  String? user;
  String? fullName;
  String? bio;
  String? location;
  String? birthDate;
  bool? verified;
  bool? isPrivate;
  int? totalLikes;
  int? followers;
  int? following;
  int? totalPosts;
  String? createdAt;
  String? updatedAt;

  AppUser(
      {this.id,
      this.user,
      this.fullName,
      this.bio,
      this.location,
      this.birthDate,
      this.verified,
      this.isPrivate,
      this.totalLikes,
      this.followers,
      this.following,
      this.totalPosts,
      this.createdAt,
      this.updatedAt});

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    fullName = json['full_name'];
    bio = json['bio'];
    location = json['location'];
    birthDate = json['birth_date'];
    verified = json['verified'];
    isPrivate = json['is_private'];
    totalLikes = json['total_likes'];
    followers = json['followers'];
    following = json['following'];
    totalPosts = json['total_posts'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['full_name'] = this.fullName;
    data['bio'] = this.bio;
    data['location'] = this.location;
    data['birth_date'] = this.birthDate;
    data['verified'] = this.verified;
    data['is_private'] = this.isPrivate;
    data['total_likes'] = this.totalLikes;
    data['followers'] = this.followers;
    data['following'] = this.following;
    data['total_posts'] = this.totalPosts;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
