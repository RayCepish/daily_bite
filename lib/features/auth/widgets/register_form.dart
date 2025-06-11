import 'package:daily_bite/core/utils/text_field_validators.dart';
import 'package:daily_bite/core/widgets/buttons/custom_button.dart';
import 'package:daily_bite/core/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onTapRegister;
  final VoidCallback onTapRegisterGoogle;

  const RegisterForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.onTapRegister,
    required this.onTapRegisterGoogle,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Name',
            controller: nameController,
            textFieldValidator: TextFieldValidator.validateName,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hintText: 'Email',
            controller: emailController,
            textFieldValidator: TextFieldValidator.validateEmail,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            isPasswordField: true,
            hintText: 'Password',
            controller: passwordController,
            textFieldValidator: TextFieldValidator.validatePassword,
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: "Register",
            onPressed: onTapRegister,
          ),
          // const SizedBox(height: 16),
          // GoogleButton(
          //   onTap: onTapRegisterGoogle,
          // )
        ],
      ),
    );
  }
}
