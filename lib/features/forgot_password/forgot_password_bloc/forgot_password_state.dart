part of 'forgot_password_bloc.dart';

enum ForgotPasswordStepEnum {
  sendEmail(0),
  enterPinCode(1),
  resetPassword(2);

  final int value;
  const ForgotPasswordStepEnum(this.value);
}

class ForgotPasswordState {
  final ForgotPasswordStepEnum step;
  final String email;
  final bool isPasswordResetSuccess;

  ForgotPasswordState({
    required this.step,
    required this.email,
    this.isPasswordResetSuccess = false,
  });

  ForgotPasswordState copyWith({
    ForgotPasswordStepEnum? step,
    String? email,
    bool? isLoading,
    String? error,
    bool? isPasswordResetSuccess,
  }) {
    return ForgotPasswordState(
      step: step ?? this.step,
      email: email ?? this.email,
      isPasswordResetSuccess:
          isPasswordResetSuccess ?? this.isPasswordResetSuccess,
    );
  }
}
