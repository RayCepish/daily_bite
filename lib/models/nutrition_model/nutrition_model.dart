import 'package:daily_bite/models/food_products/food_item_model.dart';

class NutritionModel {
  final double calories;
  final double protein;
  final double fat;
  final double carbs;
  final double? totalGrams;

  const NutritionModel({
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    this.totalGrams,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> json) {
    return NutritionModel(
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      totalGrams: (json['total_grams'] as num).toDouble(),
    );
  }

  NutritionModel operator +(NutritionModel other) {
    return NutritionModel(
      calories: calories + other.calories,
      protein: protein + other.protein,
      fat: fat + other.fat,
      carbs: carbs + other.carbs,
      totalGrams: 0,
    );
  }

  factory NutritionModel.empty() => const NutritionModel(
        protein: 0,
        fat: 0,
        carbs: 0,
        calories: 0,
        totalGrams: 0,
      );
}

NutritionModel calculateTotalNutrition(List<FoodItemModel> foods) {
  double totalCalories = 0;
  double totalProtein = 0;
  double totalFat = 0;
  double totalCarbs = 0;
  for (final food in foods) {
    totalCalories += food.calories;
    totalProtein += food.protein;
    totalFat += food.fat;
    totalCarbs += food.carbs;
  }

  return NutritionModel(
    calories: totalCalories,
    protein: totalProtein,
    fat: totalFat,
    carbs: totalCarbs,
  );
}
