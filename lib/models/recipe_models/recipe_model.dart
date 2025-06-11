import 'package:daily_bite/models/recipe_models/ingredients_model.dart';
import 'package:equatable/equatable.dart';

class RecipeModel extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? instruction;
  final List<IngredientsModel> ingredients;
  final double? calories;
  final double? protein;
  final double? fat;
  final double? carbs;
  final bool? isFavorite;

  const RecipeModel({
    this.id,
    this.name,
    this.description,
    this.instruction,
    required this.ingredients,
    this.calories,
    this.protein,
    this.fat,
    this.carbs,
    this.isFavorite,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      description: json['description'],
      instruction: json['instruction'],
      ingredients: (json['ingredients'] as List)
          .map((e) => IngredientsModel.fromJson(e))
          .toList(),
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'instruction': instruction,
        'ingredients': ingredients.map((e) => e.toJson()).toList()
      };
  double get totalGrams {
    return ingredients.fold(0.0, (sum, item) => sum + (item.grams));
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        ingredients,
        instruction,
        calories,
        protein,
        fat,
        carbs,
        isFavorite,
      ];
}
