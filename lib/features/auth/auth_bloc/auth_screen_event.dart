part of 'auth_screen_bloc.dart';

@immutable
abstract class AuthScreenEvent {}

class SwitchTabEvent extends AuthScreenEvent {
  final int tabIndex;

  SwitchTabEvent(this.tabIndex);
}

class UpdateFieldEvent extends AuthScreenEvent {
  final String? name;

  final String email;
  final String password;

  UpdateFieldEvent({
    this.name,
    required this.email,
    required this.password,
  });
}

class LoginEvent extends AuthScreenEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}

class RegisterEvent extends AuthScreenEvent {
  final String? name;

  final String email;
  final String password;

  RegisterEvent({
    this.name,
    required this.email,
    required this.password,
  });
}

class GoogleLoginEvent extends AuthScreenEvent {}

class LogoutEvent extends AuthScreenEvent {}
