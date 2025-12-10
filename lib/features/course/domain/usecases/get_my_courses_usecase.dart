import 'package:injectable/injectable.dart';
import '../../domain/entities/course_entity.dart';
import '../../domain/repositories/course_repository.dart';

@lazySingleton
class GetMyCoursesUseCase {
  final CourseRepository _repository;

  GetMyCoursesUseCase(this._repository);

  Future<List<CourseEntity>> call(String instructorId) {
    return _repository.getMyCourses(instructorId);
  }
}
