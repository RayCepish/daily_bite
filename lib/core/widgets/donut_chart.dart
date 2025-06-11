import 'package:daily_bite/core/constants/app_theme.dart';
import 'package:daily_bite/models/nutrition_model/nutrition_model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class NutrientDonutChart extends StatelessWidget {
  final NutritionModel nutritionModel;
  final bool showPercent;
  final double size;

  const NutrientDonutChart({
    super.key,
    required this.nutritionModel,
    this.showPercent = true,
    this.size = 140,
  });

  @override
  Widget build(BuildContext context) {
    final nutrition = nutritionModel;
    final total = nutrition.protein + nutrition.fat + nutrition.carbs;
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.labelLarge?.copyWith(
      color: theme.colorScheme.onSurface,
    );

    List<PieChartSectionData> sections = [];

    if (total == 0) {
      sections.add(
        PieChartSectionData(
          color: theme.colorScheme.onSecondary,
          value: 1,
          title: '0%',
          radius: size / 2,
          titleStyle: textStyle,
        ),
      );
    } else {
      sections = [
        PieChartSectionData(
          color: AppTheme.chartProteinColor,
          value: nutrition.protein,
          title: showPercent
              ? '${((nutrition.protein / total) * 100).toStringAsFixed(0)}%'
              : '',
          radius: size / 2,
          titleStyle: textStyle,
        ),
        PieChartSectionData(
          color: AppTheme.chartFatColor,
          value: nutrition.fat,
          title: showPercent
              ? '${((nutrition.fat / total) * 100).toStringAsFixed(0)}%'
              : '',
          radius: size / 2,
          titleStyle: textStyle,
        ),
        PieChartSectionData(
          color: AppTheme.chartCarbsColor,
          value: nutrition.carbs,
          title: showPercent
              ? '${((nutrition.carbs / total) * 100).toStringAsFixed(0)}%'
              : '',
          radius: size / 2,
          titleStyle: textStyle,
        ),
      ];
    }

    return SizedBox(
      height: size,
      width: size,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: size / 4,
          sectionsSpace: 2,
          sections: sections,
        ),
      ),
    );
  }
}
