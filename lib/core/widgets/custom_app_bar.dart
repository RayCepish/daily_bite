import 'package:flutter/material.dart';

class AppBarSettings {
  final String title;
  final bool showBackButton;
  final bool showNotification;
  final VoidCallback? onBackButtonPressed;

  AppBarSettings({
    required this.title,
    this.showBackButton = true,
    this.showNotification = false,
    this.onBackButtonPressed,
  });
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarSettings appBarSettings;

  const CustomAppBar({
    required this.appBarSettings,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: preferredSize.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (appBarSettings.showBackButton)
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                color: theme.colorScheme.secondary,
                onPressed: appBarSettings.onBackButtonPressed ??
                    () => Navigator.of(context).pop(),
              )
            else
              const SizedBox(width: 48),
            Expanded(
              child: Text(
                appBarSettings.title,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium,
              ),
            ),
            appBarSettings.showNotification
                ? IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {},
                  )
                : const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
