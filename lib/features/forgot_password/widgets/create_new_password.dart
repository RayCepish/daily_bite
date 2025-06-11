import 'package:daily_bite/core/utils/text_field_validators.dart';
import 'package:daily_bite/core/widgets/buttons/custom_button.dart';
import 'package:daily_bite/core/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';

class CreateNewPassword extends StatefulWidget {
  final TextEditingController passwordController;
  final VoidCallback onCreateNewPassword;

  const CreateNewPassword({
    super.key,
    required this.passwordController,
    required this.onCreateNewPassword,
  });

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool isPasswordValid = false;

  @override
  void initState() {
    super.initState();
    widget.passwordController.addListener(_validatePassword);
    _validatePassword();
  }

  void _validatePassword() {
    final text = widget.passwordController.text;
    final isValid =
        text.isNotEmpty && TextFieldValidator.validatePassword(text) == null;

    if (isPasswordValid != isValid) {
      setState(() {
        isPasswordValid = isValid;
      });
    }
  }

  @override
  void dispose() {
    widget.passwordController.removeListener(_validatePassword);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Enter new password',
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 32),
        CustomTextField(
          hintText: 'Password',
          controller: widget.passwordController,
          textFieldValidator: TextFieldValidator.validatePassword,
        ),
        const SizedBox(height: 16),
        CustomButton(
          isEnabled: isPasswordValid,
          text: "Reset Password",
          onPressed: widget.onCreateNewPassword,
        ),
      ],
    );
  }
}
