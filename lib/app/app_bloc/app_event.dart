part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class AppStartedEvent extends AppEvent {}

class ShowLoaderEvent extends AppEvent {}

class HideLoaderEvent extends AppEvent {}

class UpdateLoaderStepEvent extends AppEvent {
  final int step;
  UpdateLoaderStepEvent(this.step);
}

class ShowErrorEvent extends AppEvent {}
