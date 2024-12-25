import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart'; // This is the file where code will be generated

@JsonSerializable()
class ProfileModel {
  String? avatar;
  String username;
  String? fName;
  String? lName;
  String email;
  String bio;
  String? phone;
  String? location;

  ProfileModel({
    required this.username,
    this.avatar,
    this.fName,
    this.lName,
    this.phone,
    this.location,
    required this.email,
    required this.bio,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
