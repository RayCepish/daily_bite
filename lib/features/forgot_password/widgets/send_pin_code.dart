import 'package:daily_bite/core/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SendPinCode extends StatefulWidget {
  final TextEditingController pinCodeController;
  final VoidCallback onValidatePinCode;

  const SendPinCode({
    super.key,
    required this.pinCodeController,
    required this.onValidatePinCode,
  });

  @override
  State<SendPinCode> createState() => _SendPinCodeState();
}

class _SendPinCodeState extends State<SendPinCode> {
  bool isPinComplete = false;

  @override
  void initState() {
    super.initState();
    widget.pinCodeController.addListener(_checkPinFilled);
    _checkPinFilled();
  }

  void _checkPinFilled() {
    final isFilled = widget.pinCodeController.text.length == 4;
    if (isFilled != isPinComplete) {
      setState(() {
        isPinComplete = isFilled;
      });
    }
  }

  @override
  void dispose() {
    widget.pinCodeController.removeListener(_checkPinFilled);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Check your email',
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Enter verification code to change password',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 32),
        PinCodeTextField(
          appContext: context,
          length: 4,
          obscureText: false,
          keyboardType: TextInputType.number,
          controller: widget.pinCodeController,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 70,
            fieldWidth: 60,
            activeFillColor: Colors.transparent,
            activeColor: theme.colorScheme.primary,
            selectedColor: theme.colorScheme.primaryContainer,
            inactiveColor: theme.colorScheme.secondary,
          ),
          enableActiveFill: false,
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: "Enter PIN",
          isEnabled: isPinComplete,
          onPressed: widget.onValidatePinCode,
        ),
      ],
    );
  }
}
