import 'package:bloc/bloc.dart';
import 'package:daily_bite/core/utils/custom_try_catch.dart';
import 'package:daily_bite/models/recipe_models/recipe_model.dart';
import 'package:daily_bite/services/api/recipes_api_service.dart';
import 'package:equatable/equatable.dart';

part 'user_recipes_event.dart';
part 'user_recipes_state.dart';

class UserRecipesBloc extends Bloc<UserRecipesEvent, UserRecipesState> {
  final RecipesApiService _recipesApiService;

  UserRecipesBloc(this._recipesApiService) : super(UserRecipesState.initial()) {
    on<LoadUserRecipes>(_onLoadUserRecipes);
    on<UpdateUserRecipe>(_onUpdateRecipe);
    on<DeleteUserRecipe>(_onDeleteUserRecipe);
  }

  Future<void> _onLoadUserRecipes(
    LoadUserRecipes event,
    Emitter<UserRecipesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await customTryCatch(
      showLoader: true,
      () async {
        final response = await _recipesApiService.fetchRecipes(
          page: 1,
        );

        final List<RecipeModel> recipes = response.recipes;
        emit(state.copyWith(
          recipes: recipes,
          isLoading: false,
        ));
      },
    );
  }

  Future<void> _onUpdateRecipe(
    UpdateUserRecipe event,
    Emitter<UserRecipesState> emit,
  ) async {
    final updated = state.recipes
        .map((recipe) => recipe.id == event.recipe.id ? event.recipe : recipe)
        .toList();
    emit(state.copyWith(recipes: updated));
  }

  Future<void> _onDeleteUserRecipe(
    DeleteUserRecipe event,
    Emitter<UserRecipesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    await customTryCatch(
      showLoader: true,
      () async {
        await _recipesApiService.deleteRecipe(event.recipeId);
        final updatedList =
            state.recipes.where((r) => r.id != event.recipeId).toList();
        emit(state.copyWith(recipes: updatedList, isLoading: false));
      },
    );
  }
}
