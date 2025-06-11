import 'package:daily_bite/core/constants/app_theme.dart';
import 'package:daily_bite/core/widgets/color_legend/legend_item.dart';
import 'package:daily_bite/models/nutrition_model/nutrition_model.dart';
import 'package:flutter/material.dart';

class ColorLegend extends StatelessWidget {
  final NutritionModel? nutrition;
  const ColorLegend({
    super.key,
    this.nutrition,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (nutrition != null && nutrition?.protein != 0)
          LegendItem(
            color: AppTheme.chartProteinColor,
            label: 'Protein',
            nutrition: nutrition != null && nutrition?.protein != 0
                ? '${nutrition?.protein.toStringAsFixed(2)}g'
                : null,
          ),
        if (nutrition != null && nutrition?.fat != 0)
          LegendItem(
            color: AppTheme.chartFatColor,
            label: 'Fat',
            nutrition: nutrition != null && nutrition?.fat != 0
                ? '${nutrition?.fat.toStringAsFixed(2)}g'
                : null,
          ),
        if (nutrition != null && nutrition?.carbs != 0)
          LegendItem(
            color: AppTheme.chartCarbsColor,
            label: 'Carbs',
            nutrition: nutrition != null && nutrition?.carbs != 0
                ? '${nutrition?.carbs.toStringAsFixed(2)}g'
                : null,
          ),
      ],
    );
  }
}
