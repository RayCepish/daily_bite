// import 'dart:convert';

// class ChatResponse {
//   final String? message;
//   final Recipe? recipe;

//   ChatResponse({this.message, this.recipe});

//   factory ChatResponse.fromJson(String raw) {
//     try {
//       final json = jsonDecode(raw);
//       return ChatResponse(recipe: Recipe.fromMap(json));
//     } catch (e) {
//       return ChatResponse(message: raw);
//     }
//   }
// }

// class Recipe {
//   final String title;
//   final String description;
//   final List<Ingredient> ingredients;
//   final NutritionFacts nutritionFacts;

//   Recipe({
//     required this.title,
//     required this.description,
//     required this.ingredients,
//     required this.nutritionFacts,
//   });

//   factory Recipe.fromMap(Map<String, dynamic> map) {
//     return Recipe(
//       title: map['title'],
//       description: map['description'],
//       ingredients: List<Ingredient>.from(
//         (map['ingredients'] as List).map((x) => Ingredient.fromMap(x)),
//       ),
//       nutritionFacts: NutritionFacts.fromMap(map['nutrition']),
//     );
//   }
// }

// class Ingredient {
//   final String name;
//   final double quantity;
//   final String unit;

//   Ingredient({
//     required this.name,
//     required this.quantity,
//     required this.unit,
//   });

//   factory Ingredient.fromMap(Map<String, dynamic> map) {
//     return Ingredient(
//       name: map['name'],
//       quantity: (map['quantity'] as num).toDouble(),
//       unit: map['unit'],
//     );
//   }
// }

// class NutritionFacts {
//   final double calories;
//   final double fats;
//   final double carbohydrates;
//   final double proteins;

//   NutritionFacts({
//     required this.calories,
//     required this.fats,
//     required this.carbohydrates,
//     required this.proteins,
//   });

//   factory NutritionFacts.fromMap(Map<String, dynamic> map) {
//     return NutritionFacts(
//       calories: (map['calories'] as num).toDouble(),
//       fats: (map['fats'] as num).toDouble(),
//       carbohydrates: (map['carbohydrates'] as num).toDouble(),
//       proteins: (map['proteins'] as num).toDouble(),
//     );
//   }
// }
