part of 'splash_screen_page_bloc.dart';

@immutable
abstract class SplashScreenPageState {}

class SplashAnimationInitial extends SplashScreenPageState {}

class SplashAnimationInProgress extends SplashScreenPageState {
  final double animationValue;
  SplashAnimationInProgress(this.animationValue);
}

class SplashAnimationCompleted extends SplashScreenPageState {}
