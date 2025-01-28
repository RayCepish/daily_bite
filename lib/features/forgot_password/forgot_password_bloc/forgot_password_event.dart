part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordEvent {}

class SetEmailEvent extends ForgotPasswordEvent {
  final String? email;

  SetEmailEvent(this.email);
}
