import 'package:daily_bite/models/food_products/food_item_model.dart';

class RecipeFoodItemInfo {
  final FoodItemModel? foodItem;
  final double grams;
  final double calories;
  final double protein;
  final double fat;
  final double carbs;

  RecipeFoodItemInfo({
    this.foodItem,
    required this.grams,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
  });

  factory RecipeFoodItemInfo.fromJson(Map<String, dynamic> json) {
    return RecipeFoodItemInfo(
      foodItem:
          json['food'] != null ? FoodItemModel.fromJson(json['food']) : null,
      grams: (json['grams'] as num).toDouble(),
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
    );
  }

  factory RecipeFoodItemInfo.empty() {
    return RecipeFoodItemInfo(
      foodItem: null,
      grams: 0,
      calories: 0.0,
      protein: 0.0,
      fat: 0.0,
      carbs: 0.0,
    );
  }
}
