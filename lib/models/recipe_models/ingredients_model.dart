class IngredientsModel {
  final int foodId;
  final double grams;

  IngredientsModel({
    required this.foodId,
    required this.grams,
  });

  factory IngredientsModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('food') && json['food'] is Map) {
      final foodMap = json['food'] as Map<String, dynamic>;
      final foodId = foodMap['food_id'];
      final grams = json['grams'];

      if (foodId == null || grams == null) {
        throw Exception(
            'Missing required field in IngredientsModel (food-embedded): $json');
      }

      return IngredientsModel(
        foodId: foodId,
        grams: (grams as num).toDouble(),
      );
    }

    final foodId = json['food_id'];
    final grams = json['grams'];

    if (foodId == null || grams == null) {
      throw Exception('Missing required field in IngredientsModel: $json');
    }

    return IngredientsModel(
      foodId: foodId,
      grams: (grams as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'food_id': foodId,
        'grams': grams,
      };
}
