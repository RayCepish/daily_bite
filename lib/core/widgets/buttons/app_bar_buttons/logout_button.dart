import 'package:daily_bite/features/profile_screen/profile_bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 36,
      child: IconButton(
        icon: const Icon(
          Icons.logout,
          size: 26,
        ),
        color: theme.colorScheme.error,
        tooltip: 'Logout',
        onPressed: () => showLogoutDialog(context, theme),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            theme.colorScheme.error.withOpacity(0.1),
          ),
          shape: WidgetStateProperty.all(const CircleBorder()),
        ),
      ),
    );
  }

  void showLogoutDialog(BuildContext context, ThemeData theme) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      titleTextStyle: theme.textTheme.titleLarge
          ?.copyWith(color: theme.colorScheme.secondary),
      descTextStyle: theme.textTheme.titleMedium
          ?.copyWith(color: theme.colorScheme.secondary),
      title: 'You are leaving',
      desc:
          'You are about to log out from your account. Do you want to continue?',
      btnCancelOnPress: () {},
      btnCancelText: 'Cancel',
      btnCancelColor: theme.colorScheme.primary,
      btnOkOnPress: () {
        context.read<ProfileBloc>().add(LogoutRequested());
      },
      btnOkText: 'Yes',
      btnOkColor: theme.colorScheme.error,
    ).show();
  }
}
