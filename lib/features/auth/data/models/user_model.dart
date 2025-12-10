import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  @JsonKey(name: 'academicMemberId')
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String roleId;
  final String universityId;

  const UserModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.roleId,
    required this.universityId,
  }) : super(
         id: id,
         username: username,
         firstName: firstName,
         lastName: lastName,
         roleId: roleId,
         universityId: universityId,
       );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
