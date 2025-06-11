import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final VoidCallback? onPressed;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () {
          if (isEnabled) {
            onPressed?.call();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? theme.colorScheme.primary
              : theme.colorScheme.onSecondary,
          foregroundColor: theme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        child: Text(
          text,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
