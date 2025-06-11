import 'package:flutter/material.dart';

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 36,
      child: IconButton(
        icon: const Icon(Icons.notifications, size: 26),
        color: theme.colorScheme.primaryContainer,
        onPressed: () {},
        padding: EdgeInsets.zero,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(const CircleBorder()),
          backgroundColor: WidgetStateProperty.all(
            theme.colorScheme.primaryContainer.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
