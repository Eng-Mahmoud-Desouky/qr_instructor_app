// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['academicMemberId'] as String,
  username: json['username'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  roleId: json['roleId'] as String,
  universityId: json['universityId'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'academicMemberId': instance.id,
  'username': instance.username,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'roleId': instance.roleId,
  'universityId': instance.universityId,
};
