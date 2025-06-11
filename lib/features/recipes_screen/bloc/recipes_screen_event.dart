part of 'recipes_screen_bloc.dart';

abstract class RecipesScreenEvent extends Equatable {
  const RecipesScreenEvent();

  @override
  List<Object?> get props => [];
}

class LoadRecipeById extends RecipesScreenEvent {
  final int recipeId;

  const LoadRecipeById(this.recipeId);

  @override
  List<Object?> get props => [recipeId];
}

class LoadRecipeItemsEvent extends RecipesScreenEvent {
  final List<FoodItemModel> foodItems;

  const LoadRecipeItemsEvent(this.foodItems);

  @override
  List<Object?> get props => [foodItems];
}

class CreateOrUpdateRecipe extends RecipesScreenEvent {
  final RecipeModel recipe;

  const CreateOrUpdateRecipe(this.recipe);

  @override
  List<Object?> get props => [recipe];
}

class ToggleFavoriteRecipe extends RecipesScreenEvent {
  final int recipeId;
  final bool isCurrentlyFavorite;

  const ToggleFavoriteRecipe(
      {required this.recipeId, required this.isCurrentlyFavorite});

  @override
  List<Object?> get props => [recipeId, isCurrentlyFavorite];
}

class CalculateNutritionRequested extends RecipesScreenEvent {
  final List<IngredientsModel> ingredients;

  const CalculateNutritionRequested(this.ingredients);
  @override
  List<Object?> get props => [ingredients];
}

class DeleteRecipe extends RecipesScreenEvent {
  final int recipeId;

  const DeleteRecipe(this.recipeId);
  @override
  List<Object?> get props => [recipeId];
}
