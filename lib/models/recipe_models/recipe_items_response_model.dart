import 'package:daily_bite/models/nutrition_model/nutrition_model.dart';
import 'package:daily_bite/models/recipe_models/recipe_model.dart';

class RecipeItemsResponseModel {
  final List<RecipeModel> recipes;
  final NutritionModel totals;

  RecipeItemsResponseModel({
    required this.recipes,
    required this.totals,
  });

  factory RecipeItemsResponseModel.fromJson(Map<String, dynamic> json) {
    return RecipeItemsResponseModel(
      recipes: (json['recipes'] as List)
          .map((item) => RecipeModel.fromJson(item))
          .toList(),
      totals: NutritionModel.fromJson(json['totals']),
    );
  }
}
