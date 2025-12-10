import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/course_entity.dart';
import '../../domain/usecases/get_my_courses_usecase.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

part 'course_state.dart';

@injectable
class CourseCubit extends Cubit<CourseState> {
  final GetMyCoursesUseCase _getMyCoursesUseCase;
  final AuthRepository _authRepository;

  CourseCubit(this._getMyCoursesUseCase, this._authRepository)
    : super(CourseInitial());

  Future<void> loadCourses() async {
    emit(CourseLoading());
    try {
      final user = await _authRepository.getProfile();
      // Assuming user.id is the instructor ID needed
      final courses = await _getMyCoursesUseCase(user.id);
      emit(CourseLoaded(courses));
    } catch (e, stack) {
      debugPrint('CourseCubit: Error loading courses: $e\n$stack');
      emit(CourseError(e.toString()));
    }
  }
}
