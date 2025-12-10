// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
  id: json['courseId'] as String,
  code: json['code'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'courseId': instance.id,
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
    };
