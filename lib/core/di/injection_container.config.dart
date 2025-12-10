// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/course/data/datasources/course_remote_data_source.dart'
    as _i770;
import '../../features/course/data/repositories/course_repository_impl.dart'
    as _i9;
import '../../features/course/domain/repositories/course_repository.dart'
    as _i30;
import '../../features/course/domain/usecases/get_my_courses_usecase.dart'
    as _i801;
import '../../features/course/presentation/cubit/course_cubit.dart' as _i1027;
import '../../features/lecture/data/datasources/lecture_remote_data_source.dart'
    as _i915;
import '../../features/lecture/data/repositories/lecture_repository_impl.dart'
    as _i291;
import '../../features/lecture/domain/repositories/lecture_repository.dart'
    as _i355;
import '../../features/lecture/domain/usecases/lecture_usecases.dart' as _i924;
import '../../features/lecture/presentation/cubit/lecture_cubit.dart' as _i35;
import '../../features/qr_attendance/data/datasources/qr_remote_data_source.dart'
    as _i11;
import '../../features/qr_attendance/data/repositories/qr_repository_impl.dart'
    as _i721;
import '../../features/qr_attendance/domain/repositories/qr_repository.dart'
    as _i38;
import '../../features/qr_attendance/domain/usecases/qr_usecases.dart'
    as _i1041;
import '../../features/qr_attendance/presentation/cubit/qr_cubit.dart' as _i989;
import '../api/dio_module.dart' as _i784;
import '../router/app_router.dart' as _i81;
import 'injection_container.dart' as _i809;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    final dioModule = _$DioModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.dio(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i11.QrRemoteDataSource>(
      () => _i11.QrRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i915.LectureRemoteDataSource>(
      () => _i915.LectureRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i38.QrRepository>(
      () => _i721.QrRepositoryImpl(gh<_i11.QrRemoteDataSource>()),
    );
    gh.lazySingleton<_i107.AuthRemoteDataSource>(
      () => _i107.AuthRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i770.CourseRemoteDataSource>(
      () => _i770.CourseRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i355.LectureRepository>(
      () => _i291.LectureRepositoryImpl(gh<_i915.LectureRemoteDataSource>()),
    );
    gh.lazySingleton<_i924.GetLecturesUseCase>(
      () => _i924.GetLecturesUseCase(gh<_i355.LectureRepository>()),
    );
    gh.lazySingleton<_i924.CreateLectureUseCase>(
      () => _i924.CreateLectureUseCase(gh<_i355.LectureRepository>()),
    );
    gh.lazySingleton<_i30.CourseRepository>(
      () => _i9.CourseRepositoryImpl(gh<_i770.CourseRemoteDataSource>()),
    );
    gh.lazySingleton<_i1041.GenerateQrUseCase>(
      () => _i1041.GenerateQrUseCase(gh<_i38.QrRepository>()),
    );
    gh.lazySingleton<_i1041.GetAttendanceStatsUseCase>(
      () => _i1041.GetAttendanceStatsUseCase(gh<_i38.QrRepository>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i107.AuthRemoteDataSource>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i801.GetMyCoursesUseCase>(
      () => _i801.GetMyCoursesUseCase(gh<_i30.CourseRepository>()),
    );
    gh.lazySingleton<_i188.LoginUseCase>(
      () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i989.QrCubit>(
      () => _i989.QrCubit(
        gh<_i1041.GenerateQrUseCase>(),
        gh<_i1041.GetAttendanceStatsUseCase>(),
      ),
    );
    gh.singleton<_i117.AuthCubit>(
      () =>
          _i117.AuthCubit(gh<_i188.LoginUseCase>(), gh<_i787.AuthRepository>()),
    );
    gh.singleton<_i81.AppRouter>(() => _i81.AppRouter(gh<_i117.AuthCubit>()));
    gh.factory<_i35.LectureCubit>(
      () => _i35.LectureCubit(
        gh<_i924.GetLecturesUseCase>(),
        gh<_i924.CreateLectureUseCase>(),
        gh<_i787.AuthRepository>(),
      ),
    );
    gh.factory<_i1027.CourseCubit>(
      () => _i1027.CourseCubit(
        gh<_i801.GetMyCoursesUseCase>(),
        gh<_i787.AuthRepository>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i809.AppModule {}

class _$DioModule extends _i784.DioModule {}
