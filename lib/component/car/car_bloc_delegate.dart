import 'package:flutter_bloc/flutter_bloc.dart';

class CarBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent [event]: ${event.toString()}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition [currentState]: ${transition.currentState.toString()}');
    print('onTransition [nextState]: ${transition.nextState.toString()}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}
