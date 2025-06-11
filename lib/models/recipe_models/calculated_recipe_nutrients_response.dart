import 'package:daily_bite/models/recipe_models/recipe_food_item_info.dart';
import 'package:daily_bite/models/recipe_models/total_recipe_nutrients_model.dart';

class CalculatedRecipeNutrientsResponse {
  final List<RecipeFoodItemInfo> items;
  final TotalRecipeNutrientsModel totalNutrients;

  CalculatedRecipeNutrientsResponse({
    required this.items,
    required this.totalNutrients,
  });

  factory CalculatedRecipeNutrientsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return CalculatedRecipeNutrientsResponse(
      items: (json['ingredients'] as List)
          .map((item) => RecipeFoodItemInfo.fromJson(item))
          .toList(),
      totalNutrients: TotalRecipeNutrientsModel.fromJson(json['totals']),
    );
  }
}
