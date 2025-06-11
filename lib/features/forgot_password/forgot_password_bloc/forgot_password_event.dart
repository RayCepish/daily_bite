part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordEvent {}

class SetEmailEvent extends ForgotPasswordEvent {
  final String? email;

  SetEmailEvent(
    this.email,
  );
}

class SetPinCodeEvent extends ForgotPasswordEvent {
  final String code;

  SetPinCodeEvent(
    this.code,
  );
}

class ResetPasswordEvent extends ForgotPasswordEvent {
  final String password;

  ResetPasswordEvent(
    this.password,
  );
}

class ContinueToNextStepEvent extends ForgotPasswordEvent {}
