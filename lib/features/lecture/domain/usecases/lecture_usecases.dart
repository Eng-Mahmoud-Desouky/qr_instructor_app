import 'package:injectable/injectable.dart';
import '../../domain/entities/lecture_entity.dart';
import '../../domain/repositories/lecture_repository.dart';

@lazySingleton
class GetLecturesUseCase {
  final LectureRepository _repository;
  GetLecturesUseCase(this._repository);
  Future<List<LectureEntity>> call(String courseId, String instructorId) {
    return _repository.getLectures(courseId, instructorId);
  }
}

@lazySingleton
class CreateLectureUseCase {
  final LectureRepository _repository;
  CreateLectureUseCase(this._repository);
  Future<void> call(LectureEntity lecture, String instructorId) {
    return _repository.createLecture(lecture, instructorId);
  }
}
