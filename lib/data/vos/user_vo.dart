import 'package:json_annotation/json_annotation.dart';
part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'uid')
  String uid;
  @JsonKey(name: 'name')
  String name;

  UserVO({required this.email, required this.uid, required this.name});

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
