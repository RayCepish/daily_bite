import 'package:daily_bite/core/widgets/custom_app_bar.dart';
import 'package:daily_bite/core/widgets/main_layout.dart';
import 'package:daily_bite/features/user_recipes/bloc/user_recipes_bloc.dart';
import 'package:daily_bite/features/user_recipes/widgets/user_recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRecipesScreen extends StatelessWidget {
  const UserRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MainLayout(
      appBarSettings: AppBarSettings(
        title: 'Your Recipes',
        showBackButton: true,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BlocBuilder<UserRecipesBloc, UserRecipesState>(
          builder: (context, state) {
            if (state.recipes.isEmpty) {
              return Center(
                child: Text(
                  'You have no recipes yet.',
                  style: theme.textTheme.titleMedium,
                ),
              );
            }

            return ListView.builder(
              itemCount: state.recipes.length,
              itemBuilder: (context, index) {
                final recipe = state.recipes[index];
                return UserRecipeCard(recipe: recipe);
              },
            );
          },
        ),
      ),
    );
  }
}
