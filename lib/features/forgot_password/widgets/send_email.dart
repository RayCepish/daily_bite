import 'package:daily_bite/core/utils/text_field_validators.dart';
import 'package:daily_bite/core/widgets/buttons/custom_button.dart';
import 'package:daily_bite/core/widgets/text_fields/custom_text_field.dart';
import 'package:flutter/material.dart';

class SendEmail extends StatefulWidget {
  final ThemeData theme;
  final TextEditingController emailController;
  final VoidCallback onTapResetPassword;

  const SendEmail({
    super.key,
    required this.theme,
    required this.emailController,
    required this.onTapResetPassword,
  });

  @override
  State<SendEmail> createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    widget.emailController.addListener(() {
      final valid = TextFieldValidator.validateEmail(
            widget.emailController.text,
          ) ==
          null;

      if (valid != isValid) {
        setState(() => isValid = valid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return Column(
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
          controller: widget.emailController,
          textFieldValidator: TextFieldValidator.validateEmail,
        ),
        const SizedBox(height: 16),
        CustomButton(
          isEnabled: isValid,
          text: "Continue",
          onPressed: widget.onTapResetPassword,
        ),
      ],
    );
  }
}
