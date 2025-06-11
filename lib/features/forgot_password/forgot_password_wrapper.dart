import 'package:daily_bite/features/forgot_password/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_screen.dart';

class ForgotPasswordWrapper extends StatelessWidget {
  final String? email;

  const ForgotPasswordWrapper({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordBloc(initialEmail: email),
      child: const ForgotPasswordScreen(),
    );
  }
}
