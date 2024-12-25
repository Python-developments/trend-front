// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      username: json['username'] as String,
      avatar: json['avatar'] as String?,
      fName: json['fName'] as String?,
      lName: json['lName'] as String?,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      email: json['email'] as String,
      bio: json['bio'] as String,
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'username': instance.username,
      'fName': instance.fName,
      'lName': instance.lName,
      'email': instance.email,
      'bio': instance.bio,
      'phone': instance.phone,
      'location': instance.location,
    };
