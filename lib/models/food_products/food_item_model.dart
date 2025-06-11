class FoodItemModel {
  final int id;
  final int foodId;
  final String name;
  final double grams;
  final double calories;
  final double protein;
  final double fat;
  final double carbs;
  final String? usdaCategory;
  final String? category;
  final String? preparation;
  final String description;

  FoodItemModel({
    required this.id,
    required this.foodId,
    required this.name,
    required this.grams,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    this.usdaCategory,
    this.category,
    this.preparation,
    required this.description,
  });

  factory FoodItemModel.fromJson(Map<String, dynamic> json) {
    return FoodItemModel(
      id: json['id'],
      foodId: json['food_id'],
      name: json['name'],
      grams: json['grams'],
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      usdaCategory: json['usda_category'],
      category: json['category'],
      preparation: json['preparation'],
      description: json['description'],
    );
  }

  factory FoodItemModel.empty() {
    return FoodItemModel(
      id: 0,
      foodId: 0,
      name: '',
      grams: 0,
      calories: 0.0,
      protein: 0.0,
      fat: 0.0,
      carbs: 0.0,
      usdaCategory: null,
      category: null,
      preparation: '',
      description: '',
    );
  }
}
