import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/lecture_entity.dart';
import '../../domain/usecases/lecture_usecases.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

part 'lecture_state.dart';

@injectable
class LectureCubit extends Cubit<LectureState> {
  final GetLecturesUseCase _getLecturesUseCase;
  final CreateLectureUseCase _createLectureUseCase;
  final AuthRepository _authRepository;

  LectureCubit(
    this._getLecturesUseCase,
    this._createLectureUseCase,
    this._authRepository,
  ) : super(LectureInitial());

  Future<void> loadLectures(String courseId) async {
    emit(LectureLoading());
    try {
      final user = await _authRepository.getProfile();
      final lectures = await _getLecturesUseCase(courseId, user.id);
      emit(LectureLoaded(lectures));
    } catch (e) {
      emit(LectureError(e.toString()));
    }
  }

  Future<void> createLecture(LectureEntity lecture) async {
    debugPrint('LectureCubit: createLecture called for room ${lecture.room}');
    emit(LectureLoading());
    try {
      final user = await _authRepository.getProfile();
      debugPrint('LectureCubit: Got user profile ${user.id}');
      await _createLectureUseCase(lecture, user.id);
      debugPrint('LectureCubit: Lecture created successfully. Refreshing...');
      // Refresh list
      final lectures = await _getLecturesUseCase(lecture.courseId, user.id);
      emit(LectureLoaded(lectures));
    } catch (e, s) {
      debugPrint('LectureCubit: Error creating lecture: $e\n$s');
      emit(LectureError(e.toString()));
    }
  }
}
