import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(
            themeContext.colorScheme.primaryContainer.withOpacity(0.2),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: themeContext.colorScheme.primaryContainer),
        ),
      ),
    );
  }
}
