import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_endpoints.dart';
import '../models/lecture_model.dart';

abstract class LectureRemoteDataSource {
  Future<List<LectureModel>> getLecturesByCourse(
    String courseId,
    String instructorId,
  );
  Future<void> createLecture(Map<String, dynamic> lectureData);
}

@LazySingleton(as: LectureRemoteDataSource)
class LectureRemoteDataSourceImpl implements LectureRemoteDataSource {
  final Dio _dio;

  LectureRemoteDataSourceImpl(this._dio);

  @override
  Future<List<LectureModel>> getLecturesByCourse(
    String courseId,
    String instructorId,
  ) async {
    final response = await _dio.get(
      ApiEndpoints.findByCourseAndInstructor,
      queryParameters: {
        'courseId': courseId,
        'instructorAcademicMemberId': instructorId,
      },
    );
    final List<dynamic> data = response.data;
    return data.map((json) => LectureModel.fromJson(json)).toList();
  }

  @override
  Future<void> createLecture(Map<String, dynamic> lectureData) async {
    await _dio.post(ApiEndpoints.addLecture, data: lectureData);
  }
}
