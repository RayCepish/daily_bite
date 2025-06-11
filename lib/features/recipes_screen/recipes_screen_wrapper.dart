import 'package:daily_bite/features/recipes_screen/bloc/recipes_screen_bloc.dart';
import 'package:daily_bite/features/recipes_screen/recipes_screen.dart';
import 'package:daily_bite/models/food_products/food_item_model.dart';
import 'package:daily_bite/models/recipe_models/recipe_model.dart';
import 'package:daily_bite/services/api/recipes_api_service.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesScreenWrapper extends StatelessWidget {
  final Object extra;

  const RecipesScreenWrapper({super.key, required this.extra});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = RecipesScreenBloc(getIt<RecipesApiService>());

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (extra is RecipeModel) {
            final recipe = extra as RecipeModel;
            bloc.add(LoadRecipeById(recipe.id!));
          } else if (extra is List<FoodItemModel>) {
            final foodItems = extra as List<FoodItemModel>;
            bloc.add(LoadRecipeItemsEvent(foodItems));
          } else {
            throw ArgumentError('Invalid data passed to RecipesScreenWrapper');
          }
        });

        return bloc;
      },
      child: const RecipesScreen(),
    );
  }
}
