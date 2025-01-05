class GetProfileResponse {
  int? id;
  String? username;
  String? fullName;
  String? avatar;
  String? bio;
  String? location;
  int? followers;
  int? following;
  int? totalPosts;
  int? likesCounts;
  bool? isBusiness;
  bool? isFollowByMe;
  bool? verified;
  String? birthDate;
  String? email;
  String? phone;

  GetProfileResponse(
      {this.username,
      this.id,
      this.fullName,
      this.bio,
      this.avatar,
      this.location,
      this.followers,
      this.following,
      this.totalPosts,
      this.likesCounts,
      this.isBusiness,
      this.verified,
      this.birthDate,
      this.email,
      this.phone});

  GetProfileResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['user'];
    bio = json['bio'];
    fullName = json['full_name'];
    avatar = json['avatar'];
    location = json['location'];
    followers = json['followers'];
    following = json['following'];
    totalPosts = json['total_posts'];
    likesCounts = json['total_likes'];
    isBusiness = json['is_business'];
    verified = json['verified'];
    birthDate = json['birth_date'].toString();
    email = json['email'];
    phone = json['phone'].toString();
    isFollowByMe = json['is_followed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.username;
    data['bio'] = this.bio;
    data['location'] = this.location;
    data['followers'] = this.followers;
    data['following'] = this.following;
    data['total_posts'] = this.totalPosts;
    data['is_business'] = this.isBusiness;
    data['verified'] = this.verified;
    data['birth_date'] = this.birthDate;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
