class ApiEndpoints {
  static const String baseUrl =
      'https://smart-attendance-system-production-253e.up.railway.app'; // Replace with your actual base URL
  static const Duration connectTimeout = Duration(milliseconds: 30000);
  static const Duration receiveTimeout = Duration(milliseconds: 30000);

  // Auth
  static const String login = '/api/v1/auth/login';
  static const String checkAuth = '/api/v1/auth/check';

  // Member
  static const String myProfile = '/api/v1/member/me';

  // Course
  static const String searchCourses = '/api/v1/course/search-instructor';
  static const String courseSearchActive = '/api/v1/course/search-active';

  // Lecture
  static const String addLecture = '/api/v1/lecture/add';
  static const String deleteLecture = '/api/v1/lecture/delete';
  static const String findByCourseAndInstructor =
      '/api/v1/lecture/find-by-course-and-instructor';

  // QR Code
  static const String generateQr = '/api/v1/qr-code/generate';
  static const String findQrByLecture = '/api/v1/qr-code/find-by-lecture';
  static const String inactivateQr = '/api/v1/qr-code/inactivate';

  // Attendance
  static const String getStatistics = '/api/v1/attendance/get-statistics';
  static const String markPresent = '/api/v1/attendance/mark-as-present';
  static const String markAbsent = '/api/v1/attendance/mark-as-absent';
  static const String findPresentInLecture =
      '/api/v1/attendance/find-present-in-lecture';
  static const String findAbsentInLecture =
      '/api/v1/attendance/find-absent-in-lecture';
}
