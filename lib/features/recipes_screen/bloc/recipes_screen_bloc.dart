import 'package:bloc/bloc.dart';
import 'package:daily_bite/core/utils/custom_try_catch.dart';

import 'package:daily_bite/features/food_screen/food_bloc/food_screen_bloc.dart';
import 'package:daily_bite/features/profile_screen/profile_bloc/profile_bloc.dart';
import 'package:daily_bite/features/user_recipes/bloc/user_recipes_bloc.dart';
import 'package:daily_bite/models/food_products/food_item_model.dart';
import 'package:daily_bite/models/recipe_models/calculated_recipe_nutrients_response.dart';
import 'package:daily_bite/models/recipe_models/ingredients_model.dart';
import 'package:daily_bite/models/recipe_models/recipe_model.dart';
import 'package:daily_bite/models/nutrition_model/nutrition_model.dart';
import 'package:daily_bite/services/api/recipes_api_service.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:equatable/equatable.dart';

part 'recipes_screen_event.dart';
part 'recipes_screen_state.dart';

class RecipesScreenBloc extends Bloc<RecipesScreenEvent, RecipesScreenState> {
  final RecipesApiService _recipesApiService;

  RecipesScreenBloc(
    this._recipesApiService,
  ) : super(RecipesScreenState.initial()) {
    on<LoadRecipeItemsEvent>(_onLoadRecipeItems);
    on<CreateOrUpdateRecipe>(_onSave);
    on<ToggleFavoriteRecipe>(_onToggleFavorite);
    on<LoadRecipeById>(_onLoadRecipeById);
    on<DeleteRecipe>(_onDeleteRecipe);
  }

  Future<void> _onLoadRecipeItems(
    LoadRecipeItemsEvent event,
    Emitter<RecipesScreenState> emit,
  ) async {
    final nutrition = calculateTotalNutrition(event.foodItems);
    final grams = event.foodItems.fold<double>(
      0,
      (previousValue, element) => previousValue + element.grams,
    );
    emit(
      state.copyWith(
        ingredients: event.foodItems,
        nutrition: nutrition,
        grams: grams,
      ),
    );
  }

  Future<void> _onSave(
    CreateOrUpdateRecipe event,
    Emitter<RecipesScreenState> emit,
  ) async {
    emit(state.copyWith(isSaveLoading: true, isSaveDone: false));

    final ingredientsForApi = state.ingredients!
        .map((item) => IngredientsModel(
              foodId: item.foodId,
              grams: item.grams,
            ))
        .toList();

    final model = RecipeModel(
      id: state.recipeId,
      name: event.recipe.name,
      description: event.recipe.description,
      instruction: event.recipe.instruction,
      ingredients: ingredientsForApi,
      calories: event.recipe.calories,
      protein: event.recipe.protein,
      fat: event.recipe.fat,
      carbs: event.recipe.carbs,
    );

    await customTryCatch(
      showLoader: true,
      () async {
        if (state.recipeId != null) {
          await _recipesApiService.updateRecipe(model);
        } else {
          await _recipesApiService.createRecipe(model);
        }

        getIt<UserRecipesBloc>().add(UpdateUserRecipe(model));
        getIt<FoodScreenBloc>().add(ClearSelectedFoods());

        getIt<ProfileBloc>().add(LoadUserProfile());

        emit(state.copyWith(isSaveDone: true));
        emit(RecipesScreenState.initial());
      },
    );
  }

  Future<void> _onLoadRecipeById(
    LoadRecipeById event,
    Emitter<RecipesScreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, hasError: false));

    await customTryCatch(
      showLoader: true,
      () async {
        final recipe = await _recipesApiService.getRecipeByID(event.recipeId);

        final ingredientsForApi = recipe.ingredients.map((ingredient) {
          return IngredientsModel(
            foodId: ingredient.foodId,
            grams: ingredient.grams,
          );
        }).toList();

        final calculated =
            await _recipesApiService.getRecipeIngredients(ingredientsForApi);
        final updatedIngredients = calculated.items.map((e) {
          final f = e.foodItem!;
          return FoodItemModel(
            id: f.id,
            foodId: f.foodId,
            name: f.name,
            grams: e.grams,
            calories: f.calories,
            protein: f.protein,
            fat: f.fat,
            carbs: f.carbs,
            usdaCategory: f.usdaCategory,
            category: f.category,
            preparation: f.preparation,
            description: f.description,
          );
        }).toList();
        emit(
          state.copyWith(
            recipeId: recipe.id,
            name: recipe.name,
            description: recipe.description,
            instruction: recipe.instruction,
            calculatedRecipeNutrients: calculated,
            nutrition: NutritionModel(
              calories: calculated.totalNutrients.calories,
              protein: calculated.totalNutrients.protein,
              fat: calculated.totalNutrients.fat,
              carbs: calculated.totalNutrients.carbs,
            ),
            ingredients: updatedIngredients,
            grams: calculated.totalNutrients.totalGrams,
            isFavorite: recipe.isFavorite ?? false,
          ),
        );
      },
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteRecipe event,
    Emitter<RecipesScreenState> emit,
  ) async {
    if (state.recipeId == null) return;

    final newValue = !event.isCurrentlyFavorite;
    emit(state.copyWith(isFavorite: newValue));
    await customTryCatch(
      showLoader: true,
      () async {
        if (newValue) {
          await _recipesApiService.addToFavorites(state.recipeId!);
        } else {
          await _recipesApiService.removeFromFavorites(state.recipeId!);
        }
      },
    );
  }

  Future<void> _onDeleteRecipe(
    DeleteRecipe event,
    Emitter<RecipesScreenState> emit,
  ) async {
    emit(state.copyWith(isSaveLoading: true));

    await customTryCatch(showLoader: true, () async {
      await _recipesApiService.deleteRecipe(event.recipeId);

      getIt<UserRecipesBloc>().add(const LoadUserRecipes());
      getIt<ProfileBloc>().add(LoadUserProfile());

      emit(state.copyWith(isDeleted: true));
    });
  }
}
