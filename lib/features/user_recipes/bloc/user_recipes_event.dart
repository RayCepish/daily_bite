part of 'user_recipes_bloc.dart';

abstract class UserRecipesEvent extends Equatable {
  const UserRecipesEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserRecipes extends UserRecipesEvent {
  const LoadUserRecipes();

  @override
  List<Object?> get props => [];
}

class UpdateUserRecipe extends UserRecipesEvent {
  final RecipeModel recipe;

  const UpdateUserRecipe(this.recipe);

  @override
  List<Object?> get props => [recipe];
}

class DeleteUserRecipe extends UserRecipesEvent {
  final int recipeId;

  const DeleteUserRecipe(this.recipeId);

  @override
  List<Object?> get props => [recipeId];
}
