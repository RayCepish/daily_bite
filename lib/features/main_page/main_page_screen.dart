import 'package:daily_bite/core/widgets/animated_bottom_bar.dart';
import 'package:daily_bite/core/widgets/custom_app_bar.dart';
import 'package:daily_bite/core/widgets/main_layout.dart';
import 'package:daily_bite/features/chat_screen/chat_screen.dart';
import 'package:daily_bite/features/food_screen/food_bloc/food_screen_bloc.dart';
import 'package:daily_bite/features/food_screen/food_bloc/food_screen_state_extension.dart';
import 'package:daily_bite/features/food_screen/food_screen.dart';
import 'package:daily_bite/features/main_page/main_page_bloc/main_page_bloc.dart';
import 'package:daily_bite/features/profile_screen/profile_bloc/profile_bloc.dart';
import 'package:daily_bite/features/profile_screen/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainPageScreen extends StatelessWidget {
  const MainPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const ChatScreen(),
      const FoodScreen(),
      const ProfileScreen(),
    ];

    final tabTitles = ['Chat', 'Foods', 'Profile'];
    final icons = [
      'assets/icons/messages.png',
      'assets/icons/salad.png',
      'assets/icons/user.png',
    ];
    final name =
        context.watch<ProfileBloc>().state.userModel?.name ?? 'Champion';
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state) {
        final foodState = context.watch<FoodScreenBloc>().state;
        final hasSelectedFoods =
            foodState.selectedFoods.values.any((isSelected) => isSelected);

        return MainLayout(
          showFAB: hasSelectedFoods && state.currentIndex == 1,
          isShowingSelected: foodState.showOnlySelected,
          onClear: () {
            context.read<FoodScreenBloc>().add(ClearSelectedFoods());
          },
          onCreate: () {
            final selectedItems = context
                .read<FoodScreenBloc>()
                .state
                .selectedItemsWithGramsAndNutrition;
            if (selectedItems.isNotEmpty) {
              context.push('/create_recipe', extra: selectedItems);
            }
          },
          onToggleSelected: () {
            context.read<FoodScreenBloc>().add(ToggleShowOnlySelected());
          },
          canPop: false,
          appBarSettings: AppBarSettings(
            title: 'Hello $name',
            showBackButton: false,
            showNotification: state.currentIndex == 0,
            showTooltip: state.currentIndex == 1,
            showLogout: state.currentIndex == 2,
          ),
          child: Column(
            children: [
              Expanded(child: pages[state.currentIndex]),
              AnimatedBottomTabBar(
                labels: tabTitles,
                icons: icons,
                onTabChanged: (index) {
                  context.read<MainPageBloc>().add(ChangeTabEvent(index));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
