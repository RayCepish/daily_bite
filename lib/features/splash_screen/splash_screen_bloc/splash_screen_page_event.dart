part of 'splash_screen_page_bloc.dart';

@immutable
abstract class SplashScreenPageEvent {}

class StartAnimationEvent extends SplashScreenPageEvent {}

class WaitForProfileLoadEvent extends SplashScreenPageEvent {}
