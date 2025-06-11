import 'package:daily_bite/models/nutrition_model/nutrition_model.dart';
import 'package:daily_bite/models/food_products/food_item_model.dart';

NutritionModel calculateNutritionFromRaw(List<FoodItemModel> items) {
  double totalProtein = 0;
  double totalFat = 0;
  double totalCarbs = 0;
  double totalCalories = 0;

  for (final item in items) {
    totalProtein += item.protein;
    totalFat += item.fat;
    totalCarbs += item.carbs;
    totalCalories += item.calories;
  }

  return NutritionModel(
    protein: totalProtein,
    fat: totalFat,
    carbs: totalCarbs,
    calories: totalCalories,
  );
}
