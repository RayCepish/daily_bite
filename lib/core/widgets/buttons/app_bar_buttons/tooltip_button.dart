import 'package:flutter/material.dart';
import 'package:widget_tooltip/widget_tooltip.dart';

class TooltipButton extends StatefulWidget {
  const TooltipButton({super.key});

  @override
  State<TooltipButton> createState() => _TooltipButtonState();
}

class _TooltipButtonState extends State<TooltipButton> {
  late final TooltipController _tooltipController;

  @override
  void initState() {
    super.initState();
    _tooltipController = TooltipController();
  }

  @override
  void dispose() {
    _tooltipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WidgetTooltip(
      controller: _tooltipController,
      triggerMode: WidgetTooltipTriggerMode.tap,
      dismissMode: WidgetTooltipDismissMode.tapAnyWhere,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      targetPadding: 1,
      triangleColor: theme.colorScheme.primary,
      axis: Axis.horizontal,
      messageDecoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      message: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.2),
              blurRadius: 6,
            ),
          ],
        ),
        constraints: const BoxConstraints(maxWidth: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Form of the food:',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            const Wrap(
              spacing: 12,
              runSpacing: 6,
              children: [
                Text('💧 boiled'),
                Text('🥫 canned'),
                Text('🔆 dried'),
                Text('♨️ fried'),
                Text('❄️ frozen'),
                Text('🌡️ pasteurized'),
                Text('🌀 raw (general)'),
                Text('🥩 raw meat'),
                Text('🐟 raw fish'),
                Text('🥦 raw vegetables'),
                Text('🍎 raw fruits'),
                Text('🥗 raw salad'),
              ],
            ),
          ],
        ),
      ),
      child: Container(
        width: 36,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryFixed.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.help_outline_rounded,
            color: theme.colorScheme.primaryFixed,
            size: 26,
          ),
        ),
      ),
    );
  }
}
