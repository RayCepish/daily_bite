import 'package:daily_bite/core/widgets/buttons/custom_button.dart';
import 'package:daily_bite/core/widgets/custom_app_bar.dart';
import 'package:daily_bite/core/widgets/main_layout.dart';
import 'package:daily_bite/core/widgets/text_fields/custom_text_field.dart';
import 'package:daily_bite/features/forgot_password/forgot_password_bloc/forgot_password_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String? email;
  const ForgotPasswordScreen({
    super.key,
    this.email,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;
  @override
  void initState() {
    _emailController = TextEditingController(text: widget.email);
    context.read<ForgotPasswordBloc>().add(SetEmailEvent(widget.email));

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MainLayout(
      appBarSettings: AppBarSettings(
        title: 'Recovery Password',
      ),
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {},
        child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgot password?',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No worries, we\'ll send you reset instructions.',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    hintText: 'Email',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: "Reset Password",
                    onPressed: () {},
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
