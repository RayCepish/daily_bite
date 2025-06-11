part of 'user_recipes_bloc.dart';

class UserRecipesState extends Equatable {
  final List<RecipeModel> recipes;
  final bool isLoading;

  const UserRecipesState({
    required this.recipes,
    required this.isLoading,
  });

  factory UserRecipesState.initial() => const UserRecipesState(
        recipes: [],
        isLoading: false,
      );

  UserRecipesState copyWith({
    List<RecipeModel>? recipes,
    bool? isLoading,
  }) {
    return UserRecipesState(
      recipes: recipes ?? this.recipes,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [recipes, isLoading];
}
