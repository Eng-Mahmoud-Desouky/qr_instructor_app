import 'package:equatable/equatable.dart';

class CourseEntity extends Equatable {
  final String id;
  final String code;
  final String name;
  final String description;

  const CourseEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [id, code, name, description];
}
