import 'package:daily_bite/core/widgets/buttons/app_bar_buttons/delete_recipe_button.dart';
import 'package:daily_bite/core/widgets/buttons/app_bar_buttons/logout_button.dart';
import 'package:daily_bite/core/widgets/buttons/app_bar_buttons/mark_favorite.dart';
import 'package:daily_bite/core/widgets/buttons/app_bar_buttons/notifications_button.dart';
import 'package:daily_bite/core/widgets/buttons/app_bar_buttons/tooltip_button.dart';
import 'package:flutter/material.dart';

class AppBarSettings {
  final String title;
  final bool showBackButton,
      showNotification,
      showLogout,
      showTooltip,
      showMarkFavorite,
      showDelete;
  final VoidCallback? onBackButtonPressed;
  AppBarSettings({
    required this.title,
    this.showBackButton = true,
    this.showNotification = false,
    this.onBackButtonPressed,
    this.showLogout = false,
    this.showTooltip = false,
    this.showMarkFavorite = false,
    this.showDelete = false,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (appBarSettings.showBackButton)
              SizedBox(
                width: 36,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: theme.colorScheme.secondary,
                  onPressed: appBarSettings.onBackButtonPressed ??
                      () => Navigator.of(context).pop(),
                ),
              )
            else
              const SizedBox(width: 36),
            Expanded(
              child: Text(
                appBarSettings.title,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium,
              ),
            ),
            if (appBarSettings.showNotification) const NotificationsButton(),
            if (appBarSettings.showTooltip) const TooltipButton(),
            if (appBarSettings.showLogout) const LogoutButton(),
            if (appBarSettings.showDelete) const DeleteRecipeButton(),
            if (appBarSettings.showMarkFavorite) const MarkFavorite(),
            if (!(appBarSettings.showNotification ||
                appBarSettings.showTooltip ||
                appBarSettings.showLogout ||
                appBarSettings.showMarkFavorite ||
                appBarSettings.showDelete))
              const SizedBox(width: 36),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
