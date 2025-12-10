import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/course_entity.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel extends CourseEntity {
  @JsonKey(name: 'courseId') // Map 'courseId' from API to 'id'
  final String id;
  final String code;
  final String name;
  final String description;

  const CourseModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
  }) : super(id: id, code: code, name: name, description: description);

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}
