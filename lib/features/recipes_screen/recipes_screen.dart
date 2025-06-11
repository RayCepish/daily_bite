import 'package:daily_bite/core/utils/text_field_validators.dart';
import 'package:daily_bite/core/widgets/buttons/custom_button.dart';
import 'package:daily_bite/core/widgets/color_legend/color_legend.dart';
import 'package:daily_bite/core/widgets/custom_app_bar.dart';
import 'package:daily_bite/core/widgets/donut_chart.dart';
import 'package:daily_bite/core/widgets/main_layout.dart';
import 'package:daily_bite/core/widgets/text_fields/custom_text_field.dart';
import 'package:daily_bite/features/recipes_screen/bloc/recipes_screen_bloc.dart';
// import 'package:daily_bite/features/recipes_screen/widgets/edit_recipe_button.dart';
import 'package:daily_bite/features/recipes_screen/widgets/selected_ingredient_item.dart';
import 'package:daily_bite/models/food_products/food_item_model.dart';
import 'package:daily_bite/models/recipe_models/ingredients_model.dart';
import 'package:daily_bite/models/recipe_models/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _viewAll = false;
  final _formKey = GlobalKey<FormState>();

  List<IngredientsModel> convertFoodItemsToIngredients(
      List<FoodItemModel> items) {
    return items
        .map((item) => IngredientsModel(
              foodId: item.foodId,
              grams: item.grams,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<RecipesScreenBloc, RecipesScreenState>(
      builder: (context, state) {
        final ingredients = state.ingredients;
        final nameController = TextEditingController(text: state.name);
        final descriptionController =
            TextEditingController(text: state.description);
        final instructionController =
            TextEditingController(text: state.instruction);
        return BlocListener<RecipesScreenBloc, RecipesScreenState>(
          listenWhen: (previous, current) =>
              previous.isSaveDone != current.isSaveDone ||
              previous.isDeleted != current.isDeleted,
          listener: (context, state) {
            if (state.isSaveDone || state.isDeleted) {
              Navigator.of(context).pop();
            }
          },
          child: MainLayout(
            appBarSettings: AppBarSettings(
              title: state.recipeId != null ? state.name! : 'New Recipe',
              showBackButton: true,
              showDelete: state.recipeId != null,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (!_viewAll) ...[
                      Column(
                        children: [
                          CustomTextField(
                            textFieldValidator: TextFieldValidator.required,
                            controller: nameController,
                            hintText: state.recipeId != null
                                ? state.name!
                                : 'Recipe Name',
                            fillColor: theme.colorScheme.primaryContainer,
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            textFieldValidator: TextFieldValidator.required,
                            controller: descriptionController,
                            hintText: state.recipeId != null
                                ? state.description!
                                : 'Recipe Description',
                            fillColor: theme.colorScheme.primaryContainer,
                          ),
                          // if (state.recipeId != null) ...[
                          //   Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: EditRecipeButton(
                          //       preselectedItems: ingredients!,
                          //     ),
                          //   ),
                          // ],
                          // if (state.recipeId == null)
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '(${state.nutrition.calories.toStringAsFixed(1)}) kcal\t',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: ColorLegend(nutrition: state.nutrition),
                              ),
                              Expanded(
                                child: NutrientDonutChart(
                                  nutritionModel: state.nutrition,
                                  size: 65,
                                  showPercent: false,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                    if (!_viewAll) const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Your products (${state.ingredients!.length}) ${state.grams.toStringAsFixed(1)}g',
                            style: theme.textTheme.headlineSmall,
                          ),
                        ),
                        if (state.ingredients!.length > 4)
                          TextButton(
                            onPressed: () {
                              setState(() => _viewAll = !_viewAll);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                _viewAll ? 'Back' : 'See all',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.secondaryContainer,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: _viewAll
                            ? state.ingredients!.length
                            : state.ingredients!.length.clamp(0, 5).toInt(),
                        itemBuilder: (_, index) {
                          final item = state.ingredients![index];
                          return SelectedIngredientItem(selectedItem: item);
                        },
                      ),
                    ),
                    if (!_viewAll) ...[
                      Column(
                        children: [
                          CustomTextField(
                            textFieldValidator: TextFieldValidator.required,
                            controller: instructionController,
                            hintText: state.recipeId != null
                                ? state.instruction!
                                : 'Recipe steps instruction (max. 1000 characters)',
                            maxLines: 5,
                            maxLength: 1000,
                            fillColor: theme.colorScheme.primaryContainer,
                          ),
                          const SizedBox(height: 8),
                          CustomButton(
                            text: state.recipeId != null
                                ? 'Edit Recipe'
                                : 'Save Recipe',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<RecipesScreenBloc>().add(
                                      CreateOrUpdateRecipe(
                                        RecipeModel(
                                          id: state.recipeId,
                                          name: nameController.text.trim(),
                                          instruction:
                                              instructionController.text.trim(),
                                          description:
                                              descriptionController.text.trim(),
                                          ingredients:
                                              convertFoodItemsToIngredients(
                                            ingredients!,
                                          ),
                                          calories: state.nutrition.calories,
                                          protein: state.nutrition.protein,
                                          fat: state.nutrition.fat,
                                          carbs: state.nutrition.carbs,
                                        ),
                                      ),
                                    );
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 32)
                    ]
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
