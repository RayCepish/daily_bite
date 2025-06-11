import 'package:daily_bite/core/utils/text_field_validators.dart';
import 'package:daily_bite/core/widgets/buttons/custom_button.dart';

import 'package:daily_bite/core/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onTapForgotPassword;
  final VoidCallback onTapLogin;
  final VoidCallback onTapLoginGoogle;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onTapForgotPassword,
    required this.onTapLogin,
    required this.onTapLoginGoogle,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Email',
            controller: emailController,
            textFieldValidator: TextFieldValidator.validateEmail,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hintText: 'Password',
            controller: passwordController,
            isPasswordField: true,
            textFieldValidator: TextFieldValidator.validatePassword,
          ),
          // const SizedBox(height: 16),
          // CustomTextButton(
          //   text: 'Forgot Password?',
          //   onTap: onTapForgotPassword,
          // ),
          const SizedBox(height: 16),
          CustomButton(
            text: "Continue",
            onPressed: onTapLogin,
          ),
          // const SizedBox(height: 16),
          // GoogleButton(
          //   onTap: onTapLoginGoogle,
          // )
        ],
      ),
    );
  }
}
