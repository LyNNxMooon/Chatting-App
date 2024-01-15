import 'package:chatting_app/persistent/hive_constant.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_vo.g.dart';

@HiveType(typeId: KHiveUserVOTypeID)
@JsonSerializable()
class UserVO {
  @HiveField(0)
  @JsonKey(name: 'email')
  String email;
  @HiveField(1)
  @JsonKey(name: 'uid')
  String uid;
  @HiveField(2)
  @JsonKey(name: 'name')
  String name;
  @HiveField(3)
  @JsonKey(name: 'profile_url')
  String profileURL;

  UserVO(
      {required this.email,
      required this.uid,
      required this.name,
      required this.profileURL});

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
