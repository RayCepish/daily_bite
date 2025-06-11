import 'package:bloc/bloc.dart';
import 'package:daily_bite/core/utils/custom_try_catch.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({String? initialEmail})
      : super(
          ForgotPasswordState(
            step: ForgotPasswordStepEnum.sendEmail,
            email: initialEmail ?? '',
          ),
        ) {
    on<SetEmailEvent>(_onSetEmail);
    on<SetPinCodeEvent>(_onSetPinCode);
    on<ResetPasswordEvent>(_onResetNewPassword);
    on<ContinueToNextStepEvent>(_onContinueToNextStep);
  }

  Future<void> _onSetEmail(
    SetEmailEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    await customTryCatch(
      showLoader: true,
      () async {
        await Future.delayed(const Duration(seconds: 1));
        emit(
          state.copyWith(
            email: event.email ?? '',
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> _onSetPinCode(
    SetPinCodeEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    await customTryCatch(
      showLoader: true,
      () async {
        await Future.delayed(const Duration(seconds: 1));
        emit(
          state.copyWith(
            isLoading: false,
          ),
        );
      },
    );
  }

  Future<void> _onResetNewPassword(
    ResetPasswordEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    await customTryCatch(
      showLoader: true,
      () async {
        await Future.delayed(const Duration(seconds: 2));
        emit(
          state.copyWith(
            isLoading: false,
            isPasswordResetSuccess: true,
          ),
        );
      },
    );
  }

  void _onContinueToNextStep(
    ContinueToNextStepEvent event,
    Emitter<ForgotPasswordState> emit,
  ) {
    final nextStep = switch (state.step) {
      ForgotPasswordStepEnum.sendEmail => ForgotPasswordStepEnum.enterPinCode,
      ForgotPasswordStepEnum.enterPinCode =>
        ForgotPasswordStepEnum.resetPassword,
      ForgotPasswordStepEnum.resetPassword =>
        ForgotPasswordStepEnum.resetPassword,
    };
    emit(
      state.copyWith(step: nextStep),
    );
  }
}
