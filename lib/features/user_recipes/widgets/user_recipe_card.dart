import 'package:daily_bite/core/widgets/donut_chart.dart';
import 'package:daily_bite/models/nutrition_model/nutrition_model.dart';
import 'package:daily_bite/models/recipe_models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserRecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  const UserRecipeCard({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        context.push('/create_recipe', extra: recipe);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                    children: [
                      TextSpan(
                        text: '${recipe.name}\t',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '${recipe.totalGrams}g\n',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: recipe.description ?? '',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              NutrientDonutChart(
                nutritionModel: NutritionModel(
                  calories: recipe.calories!,
                  protein: recipe.protein!,
                  carbs: recipe.carbs!,
                  fat: recipe.fat!,
                ),
                size: 45,
                showPercent: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
