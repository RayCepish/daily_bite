import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:daily_bite/features/recipes_screen/bloc/recipes_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteRecipeButton extends StatelessWidget {
  const DeleteRecipeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<RecipesScreenBloc, RecipesScreenState>(
      builder: (context, state) {
        return SizedBox(
          width: 36,
          child: Center(
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                size: 26,
              ),
              padding: EdgeInsets.zero,
              color: theme.colorScheme.error,
              tooltip: 'Delete Recipe',
              onPressed: () => _showDeleteDialog(context, theme),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  theme.colorScheme.error.withOpacity(0.1),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, ThemeData theme) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      titleTextStyle: theme.textTheme.titleLarge?.copyWith(
        color: theme.colorScheme.secondary,
      ),
      descTextStyle: theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.secondary,
      ),
      title: 'Delete Recipe?',
      desc:
          'Are you sure you want to delete this recipe? This action cannot be undone.',
      btnCancelOnPress: () {},
      btnCancelText: 'Cancel',
      btnCancelColor: theme.colorScheme.primary,
      btnOkOnPress: () {
        final recipeId = context.read<RecipesScreenBloc>().state.recipeId;
        if (recipeId != null) {
          context.read<RecipesScreenBloc>().add(DeleteRecipe(recipeId));
        }
      },
      btnOkText: 'Delete',
      btnOkColor: theme.colorScheme.error,
    ).show();
  }
}
