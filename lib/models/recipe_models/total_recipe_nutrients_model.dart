class TotalRecipeNutrientsModel {
  final double calories;
  final double protein;
  final double fat;
  final double carbs;
  final double totalGrams;

  TotalRecipeNutrientsModel({
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.totalGrams,
  });

  factory TotalRecipeNutrientsModel.fromJson(Map<String, dynamic> json) {
    return TotalRecipeNutrientsModel(
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      totalGrams: (json['total_grams'] as num).toDouble(),
    );
  }
}
