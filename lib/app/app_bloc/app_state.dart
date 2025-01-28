part of 'app_bloc.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

class AppLoadingState extends AppState {}

class AppLoadedState extends AppState {}

class AppStartedEvent extends AppEvent {}
