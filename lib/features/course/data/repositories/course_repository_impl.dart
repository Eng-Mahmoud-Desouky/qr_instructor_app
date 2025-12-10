import 'package:injectable/injectable.dart';
import '../../domain/entities/course_entity.dart';
import '../../domain/repositories/course_repository.dart';
import '../datasources/course_remote_data_source.dart';

@LazySingleton(as: CourseRepository)
class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource _remoteDataSource;

  CourseRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<CourseEntity>> getMyCourses(String instructorId) async {
    return await _remoteDataSource.getInstructorCourses(instructorId);
  }
}
