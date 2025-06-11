import 'package:flutter/material.dart';

class AnimatedBottomTabBar extends StatefulWidget {
  final List<String> icons;
  final List<String> labels;
  final ValueChanged<int> onTabChanged;

  const AnimatedBottomTabBar({
    super.key,
    required this.icons,
    required this.labels,
    required this.onTabChanged,
  });

  @override
  State<AnimatedBottomTabBar> createState() => _AnimatedBottomTabBarState();
}

class _AnimatedBottomTabBarState extends State<AnimatedBottomTabBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 4, left: 4, bottom: 24, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          widget.icons.length,
          (index) {
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() => _selectedIndex = index);
                widget.onTabChanged(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.primary.withOpacity(0.3),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      width: 20,
                      widget.icons[index],
                      color: isSelected
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.onSecondary,
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: SizedBox(
                        width: isSelected ? 10 : 0,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isSelected ? 1.0 : 0.0,
                      child: isSelected
                          ? Text(
                              widget.labels[index],
                              style: theme.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
