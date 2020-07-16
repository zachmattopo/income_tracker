import 'dart:developer';

import 'package:bloc/bloc.dart';

class MainBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    log('onEvent $event at ${DateTime.now()}');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('onTransition $transition at ${DateTime.now()}');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    log('onError $error at ${DateTime.now()}');
    super.onError(bloc, error, stackTrace);
  }
}
