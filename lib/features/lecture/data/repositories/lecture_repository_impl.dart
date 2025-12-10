import 'package:injectable/injectable.dart';
import '../../domain/entities/lecture_entity.dart';
import '../../domain/repositories/lecture_repository.dart';
import '../datasources/lecture_remote_data_source.dart';
import '../models/lecture_model.dart'; // For converting if needed, or re-using model logic

@LazySingleton(as: LectureRepository)
class LectureRepositoryImpl implements LectureRepository {
  final LectureRemoteDataSource _remoteDataSource;

  LectureRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<LectureEntity>> getLectures(
    String courseId,
    String instructorId,
  ) async {
    return await _remoteDataSource.getLecturesByCourse(courseId, instructorId);
  }

  @override
  Future<void> createLecture(LectureEntity lecture, String instructorId) async {
    // Convert Entity to Request JSON
    // Mapping manually or using a model helper
    final requestData = {
      "courseId": lecture.courseId,
      "instructorAcademicMemberId": instructorId,
      "lectureDate": lecture.lectureDate,
      "startTime": LectureModel.timeToJson(
        lecture.startTime,
      ), // Using static helper from Model
      "endTime": LectureModel.timeToJson(lecture.endTime),
      "room": lecture.room,
      "dayOfWeek": "MONDAY", // Hardcoded for now, or calculate from Date
      // API requires dayOfWeek enum. We should calculate it from the date.
    };
    // Calculate DayOfWeek from date string
    final date = DateTime.parse(lecture.lectureDate);
    final days = [
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
      'SATURDAY',
      'SUNDAY',
    ];
    requestData['dayOfWeek'] = days[date.weekday - 1];

    await _remoteDataSource.createLecture(requestData);
  }
}
