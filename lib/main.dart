import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart';
import 'core/router/app_router.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'core/bloc_observer.dart'; // Import observer

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  // Set global observer
  Bloc.observer = AppBlocObserver();

  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'MyApp: Building with AuthCubit hash: ${getIt<AuthCubit>().hashCode}',
    );
    return BlocProvider.value(
      value: getIt<AuthCubit>()..checkAuth(),
      child: Builder(
        builder: (context) {
          final router = getIt<AppRouter>().router;
          debugPrint('MyApp: Router hash: ${router.hashCode}');
          return MaterialApp.router(
            title: 'Instructor Dashboard',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            ),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
