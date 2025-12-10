import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_endpoints.dart';
import '../models/course_model.dart';

abstract class CourseRemoteDataSource {
  Future<List<CourseModel>> getInstructorCourses(String instructorId);
}

@LazySingleton(as: CourseRemoteDataSource)
class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final Dio _dio;

  CourseRemoteDataSourceImpl(this._dio);

  @override
  Future<List<CourseModel>> getInstructorCourses(String instructorId) async {
    final response = await _dio.get(
      ApiEndpoints.searchCourses,
      queryParameters: {'instructor': instructorId},
    );
    // API returns List<ResponseCourse>
    final List<dynamic> data = response.data;
    return data.map((json) => CourseModel.fromJson(json)).toList();
  }
}
