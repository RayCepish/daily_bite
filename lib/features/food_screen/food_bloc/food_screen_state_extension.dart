import 'package:daily_bite/features/food_screen/food_bloc/food_screen_bloc.dart';
import 'package:daily_bite/models/food_products/food_item_model.dart';
import 'package:daily_bite/models/nutrition_model/nutrition_model.dart';

extension FoodScreenStateExtension on FoodScreenState {
  List<FoodItemModel> get selectedItemsWithGramsAndNutrition {
    final allFoods = filteredCategoryProducts.values.expand((e) => e).toList();

    return selectedFoods.entries
        .where((entry) => entry.value)
        .map(
          (entry) {
            final name = entry.key;
            final grams = gramsPerFood[name] ?? 100;

            final food = allFoods.firstWhere(
              (f) => f.description == name,
              orElse: () => FoodItemModel.empty(),
            );

            if (food.name == 'Unknown') return null;

            final factor = grams / 100;
            final updatedNutrition = NutritionModel(
              protein: food.protein * factor,
              fat: food.fat * factor,
              carbs: food.carbs * factor,
              calories: food.calories * factor,
            );

            return FoodItemModel(
              id: food.id,
              foodId: food.foodId,
              name: name,
              grams: grams,
              calories: updatedNutrition.calories,
              protein: updatedNutrition.protein,
              fat: updatedNutrition.fat,
              carbs: updatedNutrition.carbs,
              preparation: food.preparation,
              description: food.description,
            );
          },
        )
        .whereType<FoodItemModel>()
        .toList();
  }
}
