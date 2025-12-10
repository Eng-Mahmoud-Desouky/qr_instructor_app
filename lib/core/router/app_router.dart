import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/dashboard/presentation/pages/dashboard_screen.dart';
import '../../features/course/presentation/pages/course_list_screen.dart';
import '../../features/lecture/presentation/pages/lecture_list_screen.dart';
import '../../features/qr_attendance/presentation/pages/qr_generation_screen.dart';

@singleton
class AppRouter {
  final AuthCubit _authCubit;

  AppRouter(this._authCubit);

  late final GoRouter router = GoRouter(
    initialLocation: '/login', // Start at login, guard will redirect if auth
    refreshListenable: GoRouterRefreshStream(_authCubit.stream),
    redirect: (context, state) {
      final isLoggedIn = _authCubit.state is AuthAuthenticated;
      final isLoggingIn = state.uri.toString() == '/login';

      print(
        'AppRouter: redirect called. LoggedIn: $isLoggedIn, CurrentPath: ${state.uri.toString()}',
      );
      print(
        'AppRouter: AuthCubit Hash: ${_authCubit.hashCode}, State: ${_authCubit.state}',
      );

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn)
        return '/dashboard/courses'; // Default to courses
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) =>
            const DashboardScreen(child: SizedBox()), // Placeholder
        routes: [
          GoRoute(
            path: 'courses',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(child: CourseListScreen()),
            ),
            routes: [
              GoRoute(
                path: ':courseId/lectures',
                pageBuilder: (context, state) {
                  final courseId = state.pathParameters['courseId']!;
                  return NoTransitionPage(
                    child: DashboardScreen(
                      child: LectureListScreen(courseId: courseId),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/dashboard/lectures/:lectureId/qr',
        builder: (context, state) {
          final lectureId = state.pathParameters['lectureId']!;
          return DashboardScreen(
            child: QrGenerationScreen(lectureId: lectureId),
          );
        },
      ),
    ],
  );
}

// Helper for GoRouter refresh
class GoRouterRefreshStream extends ChangeNotifier {
  late final dynamic _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.listen((dynamic _) {
      print('GoRouterRefreshStream: Stream updated, notifying listeners.');
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
