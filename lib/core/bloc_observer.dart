import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint(
      'BlocObserver: onCreate -- ${bloc.runtimeType} (Hash: ${bloc.hashCode})',
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint(
      'BlocObserver: onChange -- ${bloc.runtimeType} (Hash: ${bloc.hashCode}) \n   Current: ${change.currentState}\n   Next: ${change.nextState}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint(
      'BlocObserver: onError -- ${bloc.runtimeType} (Hash: ${bloc.hashCode}) -- $error',
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint(
      'BlocObserver: onClose -- ${bloc.runtimeType} (Hash: ${bloc.hashCode})',
    );
  }
}
