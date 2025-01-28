part of 'auth_screen_bloc.dart';

@immutable
abstract class AuthScreenState {}

class AuthInProgress extends AuthScreenState {}

class AuthScreenInitial extends AuthScreenState {
  final int currentTab;
  final String email;
  final String password;
  final String name;

  AuthScreenInitial({
    this.currentTab = 0,
    this.email = '',
    this.password = '',
    this.name = '',
  });
}

class AuthSuccess extends AuthScreenState {}

class AuthFailure extends AuthScreenState {
  final String error;

  AuthFailure(this.error);
}
