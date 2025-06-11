import 'package:daily_bite/core/constants/app_theme.dart';
import 'package:daily_bite/models/food_products/food_item_model.dart';
import 'package:flutter/material.dart';

class SelectedIngredientItem extends StatelessWidget {
  final FoodItemModel selectedItem;
  const SelectedIngredientItem({
    required this.selectedItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color getDominantNutrientColor(FoodItemModel foodItem) {
      final values = {
        AppTheme.chartProteinColor: foodItem.protein,
        AppTheme.chartFatColor: foodItem.fat,
        AppTheme.chartCarbsColor: foodItem.carbs,
      };
      return values.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: getDominantNutrientColor(selectedItem).withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: getDominantNutrientColor(selectedItem), width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${selectedItem.description},',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: getDominantNutrientColor(selectedItem),
              ),
            ),
          ),
          Text(
            '${selectedItem.grams.toStringAsFixed(1)}g',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: getDominantNutrientColor(selectedItem),
            ),
          ),
        ],
      ),
    );
  }
}
