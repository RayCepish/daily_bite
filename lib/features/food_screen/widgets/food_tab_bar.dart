import 'package:daily_bite/core/utils/foods_utils/allowed_food_categories.dart';
import 'package:flutter/material.dart';

class FoodTabBar extends StatefulWidget {
  final TabController controller;
  final List<String> categories;

  const FoodTabBar({
    super.key,
    required this.controller,
    required this.categories,
  });

  @override
  State<FoodTabBar> createState() => _FoodTabBarState();
}

class _FoodTabBarState extends State<FoodTabBar> {
  final _scrollController = ScrollController();
  final _tabKeys = <GlobalKey>[];
  final allowedFoodCategories = AllowedFoodCategories();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scrollToSelectedTab);
    _tabKeys
        .addAll(List.generate(widget.categories.length, (_) => GlobalKey()));
  }

  void _scrollToSelectedTab() {
    final selectedIndex = widget.controller.index;
    final selectedKey = _tabKeys[selectedIndex];

    final context = selectedKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        alignment: 0.5,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollToSelectedTab);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        return SizedBox(
          height: 36,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                final isSelected = widget.controller.index == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => widget.controller.animateTo(index),
                    child: AnimatedContainer(
                      key: _tabKeys[index],
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primaryContainer
                            : theme.colorScheme.primaryContainer
                                .withOpacity(0.4),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Text(
                          allowedFoodCategories
                              .getLabel(widget.categories[index]),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: isSelected
                                ? theme.colorScheme.secondaryContainer
                                : theme.colorScheme.secondary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
