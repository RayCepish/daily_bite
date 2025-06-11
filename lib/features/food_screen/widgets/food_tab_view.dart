import 'package:daily_bite/core/widgets/text_fields/custom_text_field.dart';
import 'package:daily_bite/models/food_products/food_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daily_bite/features/food_screen/food_bloc/food_screen_bloc.dart';
import 'package:daily_bite/features/food_screen/widgets/food_card.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FoodTabView extends StatelessWidget {
  final List<String> categories;
  final TabController tabController;
  final Map<String, TextEditingController> controllers;
  final Map<String, PagingController<int, FoodItemModel>> pagingControllers;

  const FoodTabView({
    super.key,
    required this.categories,
    required this.tabController,
    required this.controllers,
    required this.pagingControllers,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: categories.map(
          (category) {
            return BlocBuilder<FoodScreenBloc, FoodScreenState>(
              builder: (context, state) {
                final items = state.filteredCategoryProducts[category] ?? [];
                final pagingController = pagingControllers[category]!;

                final filteredItems = state.showOnlySelected
                    ? items
                        .where((item) =>
                            state.selectedFoods[item.description] == true)
                        .toList()
                    : items;

                final existingItems = pagingController.itemList ?? [];
                final nextPage = filteredItems.length < 10
                    ? null
                    : ((filteredItems.length ~/ 10) + 1);

                if (existingItems.length != filteredItems.length ||
                    state.showOnlySelected) {
                  pagingController.value = PagingState(
                    itemList: filteredItems,
                    nextPageKey: nextPage,
                    error: null,
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomTextField(
                        fillColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        controller: controllers[category]!,
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search),
                        onChanged: (query) {
                          context.read<FoodScreenBloc>().add(
                                SearchProductInCategory(
                                  category: category,
                                  query: query,
                                ),
                              );
                        },
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: PagedListView<int, FoodItemModel>(
                          pagingController: pagingController,
                          builderDelegate:
                              PagedChildBuilderDelegate<FoodItemModel>(
                            newPageProgressIndicatorBuilder: (_) =>
                                const SizedBox.shrink(),
                            firstPageProgressIndicatorBuilder: (_) =>
                                const SizedBox.shrink(),
                            noItemsFoundIndicatorBuilder: (_) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: theme.colorScheme.onSecondary,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'No matching products',
                                  style: theme.textTheme.titleMedium,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Try another keyword or clear the search',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            itemBuilder: (context, item, index) =>
                                _buildFoodCard(context, item, state),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildFoodCard(
      BuildContext context, FoodItemModel item, FoodScreenState state) {
    final grams = state.gramsPerFood[item.description] ?? 100;
    final isSelected = state.selectedFoods[item.description] ?? false;

    return FoodCard(
      item: item,
      gramsValue: grams,
      isSelected: isSelected,
      onGramsChanged: (value) {
        context.read<FoodScreenBloc>().add(
              ChangeFoodGrams(itemName: item.description, grams: value),
            );
      },
      onSelectedChanged: (selected) {
        context.read<FoodScreenBloc>().add(
              ToggleFoodSelection(
                itemName: item.description,
                isSelected: selected,
              ),
            );
      },
    );
  }
}
