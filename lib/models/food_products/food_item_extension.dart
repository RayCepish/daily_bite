import 'package:daily_bite/models/food_products/food_item_model.dart';
import 'package:daily_bite/models/nutrition_model/nutrition_model.dart';

extension FoodItemX on FoodItemModel {
  NutritionModel withGrams({
    required double grams,
    required FoodItemModel item,
  }) {
    final factor = grams / 100;
    return NutritionModel(
      protein: item.protein * factor,
      fat: item.fat * factor,
      carbs: item.carbs * factor,
      calories: item.calories * factor,
    );
  }
}
