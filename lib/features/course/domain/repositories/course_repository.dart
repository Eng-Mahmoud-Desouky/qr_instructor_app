import '../../domain/entities/course_entity.dart';

abstract class CourseRepository {
  Future<List<CourseEntity>> getMyCourses(String instructorId);
}
