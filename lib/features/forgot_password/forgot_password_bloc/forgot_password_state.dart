part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordWithEmail extends ForgotPasswordState {
  final String email;

  ForgotPasswordWithEmail(this.email);
}
