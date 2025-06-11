import 'package:daily_bite/core/utils/foods_utils/allowed_food_categories.dart';
import 'package:daily_bite/features/food_screen/food_bloc/food_screen_bloc.dart';
import 'package:daily_bite/features/food_screen/widgets/food_tab_bar.dart';
import 'package:daily_bite/features/food_screen/widgets/food_tab_view.dart';
import 'package:daily_bite/models/food_products/food_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  final Map<String, TextEditingController> _controllers = {};
  final Map<String, PagingController<int, FoodItemModel>> _pagingControllers =
      {};
  final allowedFoodCategories = AllowedFoodCategories();
  @override
  void initState() {
    super.initState();

    final foodBloc = context.read<FoodScreenBloc>();
    final state = foodBloc.state;
    final categories = allowedFoodCategories.filterAllowed(
      state.availableCategories.categories,
    );
    _tabController = TabController(
      length: categories.length,
      vsync: this,
      initialIndex: state.lastVisitedTabIndex,
    );

    _tabController.addListener(() {
      context.read<FoodScreenBloc>().add(
            ChangeTabIndex(_tabController.index),
          );
    });

    for (final category in categories) {
      final categoryName = category;

      final searchQuery = state.searchQueries[categoryName] ?? '';
      final controller = TextEditingController(text: searchQuery);

      controller.addListener(
        () {
          context.read<FoodScreenBloc>().add(
                SearchProductInCategory(
                  category: categoryName,
                  query: controller.text,
                ),
              );
        },
      );

      _controllers[categoryName] = controller;

      final pagingController =
          PagingController<int, FoodItemModel>(firstPageKey: 1);
      pagingController.addPageRequestListener((page) {
        context.read<FoodScreenBloc>().add(
              LoadNextCategoryPage(category: categoryName, page: page),
            );
      });

      _pagingControllers[categoryName] = pagingController;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    for (final controller in _pagingControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.select(
      (FoodScreenBloc bloc) => allowedFoodCategories.filterAllowed(
        bloc.state.availableCategories.categories,
      ),
    );
    return Column(
      children: [
        FoodTabBar(
          controller: _tabController,
          categories: categories,
        ),
        FoodTabView(
          categories: categories,
          tabController: _tabController,
          controllers: _controllers,
          pagingControllers: _pagingControllers,
        ),
      ],
    );
  }
}
