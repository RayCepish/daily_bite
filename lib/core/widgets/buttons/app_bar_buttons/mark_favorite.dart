import 'package:daily_bite/features/recipes_screen/bloc/recipes_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarkFavorite extends StatelessWidget {
  const MarkFavorite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<RecipesScreenBloc, RecipesScreenState>(
      builder: (context, state) {
        return SizedBox(
          width: 36,
          child: IconButton(
            icon: Icon(
              size: 26,
              state.isFavorite != true ? Icons.star : Icons.star_border,
              color: theme.colorScheme.secondaryContainer,
            ),
            onPressed: () {
              context.read<RecipesScreenBloc>().add(
                    ToggleFavoriteRecipe(
                        recipeId: state.recipeId!,
                        isCurrentlyFavorite: state.isFavorite),
                  );
            },
            padding: EdgeInsets.zero,
            style: ButtonStyle(
              shape: WidgetStateProperty.all(const CircleBorder()),
              backgroundColor: WidgetStateProperty.all(
                theme.colorScheme.primaryContainer,
              ),
            ),
          ),
        );
      },
    );
  }
}
