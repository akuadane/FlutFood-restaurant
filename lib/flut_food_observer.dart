import 'package:flutter_bloc/flutter_bloc.dart';

class FlutFoodObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print("===Event===: ${event.runtimeType}");
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print("===Error===: ${cubit.runtimeType} $error");
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(
        "===Transition===: ${bloc.runtimeType} because ${transition.event.runtimeType} from ${transition.currentState.runtimeType} to ${transition.nextState.runtimeType}");
    super.onTransition(bloc, transition);
  }
}
