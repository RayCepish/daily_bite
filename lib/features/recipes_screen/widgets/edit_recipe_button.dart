import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:daily_bite/models/food_products/food_item_model.dart';

class EditRecipeButton extends StatelessWidget {
  final List<FoodItemModel> preselectedItems;

  const EditRecipeButton({
    super.key,
    required this.preselectedItems,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          theme.colorScheme.primary,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        minimumSize: WidgetStateProperty.all(
          const Size(140, 28),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        ),
      ),
      onPressed: () {
        context.push('/food_editor', extra: preselectedItems);
      },
      icon: Icon(
        Icons.edit,
        color: theme.colorScheme.surface,
      ),
      label: Text(
        "Edit Ingredients",
        style: theme.textTheme.titleMedium!
            .copyWith(color: theme.colorScheme.surface),
      ),
    );
  }
}
