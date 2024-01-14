// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      email: json['email'] as String,
      uid: json['uid'] as String,
      name: json['name'] as String,
      profileURL: json['profile_url'] as String,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'email': instance.email,
      'uid': instance.uid,
      'name': instance.name,
      'profile_url': instance.profileURL,
    };
