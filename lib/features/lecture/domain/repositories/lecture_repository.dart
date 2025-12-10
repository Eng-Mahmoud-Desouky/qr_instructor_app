import '../../domain/entities/lecture_entity.dart';

abstract class LectureRepository {
  Future<List<LectureEntity>> getLectures(String courseId, String instructorId);
  Future<void> createLecture(LectureEntity lecture, String instructorId);
}
