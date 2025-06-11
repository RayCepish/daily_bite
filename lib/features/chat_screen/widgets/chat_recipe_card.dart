// import 'package:daily_bite/models/chat_models/chat_recipe_model.dart';
// import 'package:daily_bite/models/recipe_models/recipe_model.dart';
// import 'package:flutter/material.dart';

// class ChatRecipeCard extends StatelessWidget {
//   final RecipeModel recipe;
//   final VoidCallback? onSave;

//   const ChatRecipeCard({
//     super.key,
//     required this.recipe,
//     this.onSave,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surfaceVariant,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             recipe.title,
//             style: theme.textTheme.titleMedium?.copyWith(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             recipe.description,
//             style: theme.textTheme.bodyMedium,
//           ),
//           const SizedBox(height: 12),
//           Text(
//             'Інгредієнти:',
//             style: theme.textTheme.labelLarge?.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           ...recipe.ingredients.map((ingredient) => Text(
//                 '• ${ingredient.name} — ${ingredient.quantity} ${ingredient.unit}',
//                 style: theme.textTheme.bodySmall,
//               )),
//           const SizedBox(height: 12),
//           Text(
//             'Харчова цінність:',
//             style: theme.textTheme.labelLarge?.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Text('Калорії: ${recipe.nutritionFacts.calories} ккал'),
//           Text('Жири: ${recipe.nutritionFacts.fats} г'),
//           Text('Вуглеводи: ${recipe.nutritionFacts.carbohydrates} г'),
//           Text('Білки: ${recipe.nutritionFacts.proteins} г'),
//           const SizedBox(height: 8),
//           if (onSave != null)
//             TextButton.icon(
//               onPressed: onSave,
//               icon: const Icon(Icons.bookmark),
//               label: const Text("Зберегти страву"),
//             ),
//         ],
//       ),
//     );
//   }
// }
