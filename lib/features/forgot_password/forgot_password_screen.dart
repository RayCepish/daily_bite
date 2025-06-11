import 'package:daily_bite/core/widgets/custom_app_bar.dart';
import 'package:daily_bite/core/widgets/main_layout.dart';
import 'package:daily_bite/features/forgot_password/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:daily_bite/features/forgot_password/widgets/create_new_password.dart';
import 'package:daily_bite/features/forgot_password/widgets/send_email.dart';
import 'package:daily_bite/features/forgot_password/widgets/send_pin_code.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    super.key,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController,
      _pinCodeController,
      _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _pinCodeController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarSettings: AppBarSettings(
        title: 'Recovery Password',
      ),
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state.isPasswordResetSuccess) {
            context.go('/auth');
          }
        },
        child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (context, state) {
            final index = state.step.value;
            if (_emailController.text != state.email) {
              _emailController.text = state.email;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IndexedStack(
                index: index,
                children: [
                  SendEmail(
                    emailController: _emailController,
                    onTapResetPassword: () {
                      context.read<ForgotPasswordBloc>().add(
                            SetEmailEvent(_emailController.text),
                          );
                      context
                          .read<ForgotPasswordBloc>()
                          .add(ContinueToNextStepEvent());
                    },
                    theme: Theme.of(context),
                  ),
                  SendPinCode(
                    pinCodeController: _pinCodeController,
                    onValidatePinCode: () {
                      context.read<ForgotPasswordBloc>().add(
                            SetPinCodeEvent(
                              _pinCodeController.text,
                            ),
                          );
                      context
                          .read<ForgotPasswordBloc>()
                          .add(ContinueToNextStepEvent());
                    },
                  ),
                  CreateNewPassword(
                    passwordController: _passwordController,
                    onCreateNewPassword: () {
                      context.read<ForgotPasswordBloc>().add(
                            ResetPasswordEvent(
                              _passwordController.text,
                            ),
                          );
                      context
                          .read<ForgotPasswordBloc>()
                          .add(ContinueToNextStepEvent());
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
