library splash_screen_page_bloc;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_screen_page_state.dart';
part 'splash_screen_page_event.dart';

class SplashScreenPageBloc
    extends Bloc<SplashScreenPageEvent, SplashScreenPageState> {
  SplashScreenPageBloc() : super(SplashAnimationInitial()) {
    on<StartAnimationEvent>(_onStartAnimation);
  }

  Future<void> _onStartAnimation(
      StartAnimationEvent event, Emitter<SplashScreenPageState> emit) async {
    const int duration = 2300;
    const int stepTime = 16;
    const int steps = duration ~/ stepTime;

    for (int i = 0; i <= steps; i++) {
      final double animationValue = i / steps;
      emit(SplashAnimationInProgress(animationValue));
      await Future.delayed(const Duration(milliseconds: stepTime));
    }

    emit(SplashAnimationCompleted());
  }
}
