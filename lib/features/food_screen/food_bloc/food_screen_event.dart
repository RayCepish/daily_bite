part of 'food_screen_bloc.dart';

abstract class FoodScreenEvent extends Equatable {
  const FoodScreenEvent();

  @override
  List<Object> get props => [];
}

class FetchCategories extends FoodScreenEvent {}

class LoadInitialCategories extends FoodScreenEvent {
  final List<String> categories;

  const LoadInitialCategories(this.categories);

  @override
  List<Object> get props => [categories];
}

class LoadNextCategoryPage extends FoodScreenEvent {
  final String category;
  final int page;

  const LoadNextCategoryPage({required this.category, required this.page});
  @override
  List<Object> get props => [category, page];
}

class SearchProductInCategory extends FoodScreenEvent {
  final String category;
  final String query;

  const SearchProductInCategory({required this.category, required this.query});

  @override
  List<Object> get props => [category, query];
}

class ChangeFoodGrams extends FoodScreenEvent {
  final String itemName;
  final double grams;

  const ChangeFoodGrams({required this.itemName, required this.grams});
}

class ToggleFoodSelection extends FoodScreenEvent {
  final String itemName;
  final bool isSelected;

  const ToggleFoodSelection({required this.itemName, required this.isSelected});
}

class ClearSelectedFoods extends FoodScreenEvent {}

class ToggleShowOnlySelected extends FoodScreenEvent {}

class ChangeTabIndex extends FoodScreenEvent {
  final int tabIndex;

  const ChangeTabIndex(this.tabIndex);
}

class LoadFoodsByUsdaIds extends FoodScreenEvent {
  final List<FoodItemModel> items;

  const LoadFoodsByUsdaIds(this.items);

  @override
  List<Object> get props => [items];
}
