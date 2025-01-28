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

class LoginEvent extends AuthScreenEvent {}

class RegisterEvent extends AuthScreenEvent {}
