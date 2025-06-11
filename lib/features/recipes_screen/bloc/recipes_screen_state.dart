part of 'recipes_screen_bloc.dart';

class RecipesScreenState extends Equatable {
  final List<FoodItemModel>? ingredients;
  final CalculatedRecipeNutrientsResponse? calculatedRecipeNutrients;

  final NutritionModel nutrition;
  final int? recipeId;
  final String? name;
  final String? description;
  final String? instruction;
  final double grams;
  final bool isSaveLoading;
  final bool isSaveDone;
  final bool isFavorite;
  final bool isLoading;
  final bool hasError;
  final bool isDeleted;

  const RecipesScreenState({
    this.ingredients,
    this.calculatedRecipeNutrients,
    required this.nutrition,
    this.recipeId,
    this.name = '',
    this.description,
    this.instruction,
    required this.grams,
    this.isSaveLoading = false,
    this.isSaveDone = false,
    this.isFavorite = false,
    this.isLoading = false,
    this.hasError = false,
    this.isDeleted = false,
  });

  factory RecipesScreenState.initial() => RecipesScreenState(
        ingredients: const [],
        calculatedRecipeNutrients: null,
        nutrition: NutritionModel.empty(),
        recipeId: null,
        name: '',
        description: null,
        instruction: null,
        grams: 0,
        isSaveLoading: false,
        isSaveDone: false,
        isFavorite: false,
        isLoading: false,
        hasError: false,
        isDeleted: false,
      );

  RecipesScreenState copyWith({
    List<FoodItemModel>? ingredients,
    CalculatedRecipeNutrientsResponse? calculatedRecipeNutrients,
    NutritionModel? nutrition,
    int? recipeId,
    String? name,
    String? description,
    String? instruction,
    double? grams,
    bool? isSaveLoading,
    bool? isSaveDone,
    bool? isFavorite,
    bool? isLoading,
    bool? hasError,
    bool? isDeleted,
  }) {
    return RecipesScreenState(
      ingredients: ingredients ?? this.ingredients,
      calculatedRecipeNutrients:
          calculatedRecipeNutrients ?? this.calculatedRecipeNutrients,
      nutrition: nutrition ?? this.nutrition,
      recipeId: recipeId ?? this.recipeId,
      name: name ?? this.name,
      description: description ?? this.description,
      instruction: instruction ?? this.instruction,
      grams: grams ?? this.grams,
      isSaveLoading: isSaveLoading ?? this.isSaveLoading,
      isSaveDone: isSaveDone ?? this.isSaveDone,
      isFavorite: isFavorite ?? this.isFavorite,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        ingredients,
        nutrition,
        recipeId,
        name,
        description,
        instruction,
        grams,
        isSaveLoading,
        isSaveDone,
        isFavorite,
        isLoading,
        hasError,
        isDeleted,
      ];
}
