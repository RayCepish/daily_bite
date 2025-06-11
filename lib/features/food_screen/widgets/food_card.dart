import 'package:daily_bite/core/utils/foods_utils/determine_food_product_type.dart';
import 'package:daily_bite/core/widgets/color_legend/color_legend.dart';
import 'package:daily_bite/core/widgets/donut_chart.dart';
import 'package:daily_bite/features/food_screen/widgets/grams_sliderr.dart';
import 'package:daily_bite/models/food_products/food_item_model.dart';
import 'package:daily_bite/models/food_products/food_item_extension.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final FoodItemModel item;
  final double gramsValue;
  final bool isSelected;
  final ValueChanged<double> onGramsChanged;
  final ValueChanged<bool> onSelectedChanged;

  const FoodCard({
    super.key,
    required this.item,
    required this.gramsValue,
    required this.isSelected,
    required this.onGramsChanged,
    required this.onSelectedChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaledNutrition = item.withGrams(grams: gramsValue, item: item);

    final determinateProductType = DeterminateFoodProductType();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 260,
                  child: RichText(
                    text: TextSpan(
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(
                          text: '${item.name}\t',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${gramsValue.round()}g\t\t',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text:
                              '(${scaledNutrition.calories.toStringAsFixed(1)}) kcal\t',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '${determinateProductType.getEmojis(
                                preparation: item.preparation,
                                category: item.category!,
                              ).join(' ')}\n',
                          style: const TextStyle(fontSize: 16),
                        ),
                        TextSpan(
                          text: determinateProductType
                              .cleanDescription(item.description),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            // height: 1.5,
                          ),
                        ),
                        const WidgetSpan(child: SizedBox(height: 4)),
                      ],
                    ),
                    maxLines: 3,
                  ),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      onSelectedChanged(value!);
                    },
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ColorLegend(nutrition: scaledNutrition),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: NutrientDonutChart(
                    nutritionModel: scaledNutrition,
                    size: 55,
                    showPercent: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isSelected) ...[
              Container(
                // color: Colors.amber,
                height: 16,
                child: GramSlider(
                  initialValue: gramsValue.toInt(),
                  onChanged: (int newValue) =>
                      onGramsChanged(newValue.toDouble()),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
