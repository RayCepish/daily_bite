import 'package:daily_bite/core/widgets/custom_app_bar.dart';
import 'package:daily_bite/core/widgets/main_layout.dart';
import 'package:daily_bite/features/food_screen/food_bloc/food_screen_bloc.dart';

import 'package:daily_bite/features/food_screen/food_screen.dart';
import 'package:daily_bite/models/food_products/food_item_model.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodScreenWrapper extends StatelessWidget {
  final List<FoodItemModel> preselectedItems;

  const FoodScreenWrapper({super.key, required this.preselectedItems});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<FoodScreenBloc>()..add(LoadFoodsByUsdaIds(preselectedItems)),
      child: BlocBuilder<FoodScreenBloc, FoodScreenState>(
        builder: (context, state) {
          return MainLayout(
            showFAB: state.hasSelectedItems,
            showCreateFABButton: false,
            appBarSettings: AppBarSettings(
              showBackButton: true,
              title: 'Food',
            ),
            child: const FoodScreen(),
          );
        },
      ),
    );
  }
}
