import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String? nutrition;

  const LegendItem({
    super.key,
    required this.color,
    required this.label,
    this.nutrition,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: nutrition == null ? 6 : 0),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            nutrition == null ? label : '$label $nutrition',
            style: nutrition == null
                ? theme.textTheme.bodyLarge
                : theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
