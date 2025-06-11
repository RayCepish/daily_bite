part of 'food_screen_bloc.dart';

class FoodScreenState extends Equatable {
  final Map<String, Set<int>> loadedPages;
  final FoodCategoryModel availableCategories;
  final Map<String, List<FoodItemModel>> allCategoryProducts;
  final Map<String, List<FoodItemModel>> filteredCategoryProducts;
  final Map<String, bool> selectedFoods;
  final Map<String, double> gramsPerFood;
  final bool showOnlySelected;
  final int lastVisitedTabIndex;
  final Map<String, String> searchQueries;

  const FoodScreenState({
    required this.loadedPages,
    required this.availableCategories,
    required this.allCategoryProducts,
    required this.filteredCategoryProducts,
    this.selectedFoods = const {},
    this.gramsPerFood = const {},
    this.showOnlySelected = false,
    required this.lastVisitedTabIndex,
    required this.searchQueries,
  });

  factory FoodScreenState.initial() => FoodScreenState(
        loadedPages: const {},
        availableCategories: FoodCategoryModel(
          categories: [],
          preparations: [],
        ),
        allCategoryProducts: const {},
        filteredCategoryProducts: const {},
        selectedFoods: const {},
        gramsPerFood: const {},
        showOnlySelected: false,
        lastVisitedTabIndex: 0,
        searchQueries: const {},
      );

  FoodScreenState copyWith({
    Map<String, Set<int>>? loadedPages,
    FoodCategoryModel? availableCategories,
    Map<String, List<FoodItemModel>>? allCategoryProducts,
    Map<String, List<FoodItemModel>>? filteredCategoryProducts,
    Map<String, bool>? selectedFoods,
    Map<String, double>? gramsPerFood,
    bool? showOnlySelected,
    int? lastVisitedTabIndex,
    Map<String, String>? searchQueries,
  }) {
    return FoodScreenState(
      loadedPages: loadedPages ?? this.loadedPages,
      availableCategories: availableCategories ?? this.availableCategories,
      allCategoryProducts: allCategoryProducts ?? this.allCategoryProducts,
      filteredCategoryProducts:
          filteredCategoryProducts ?? this.filteredCategoryProducts,
      selectedFoods: selectedFoods ?? this.selectedFoods,
      gramsPerFood: gramsPerFood ?? this.gramsPerFood,
      showOnlySelected: showOnlySelected ?? this.showOnlySelected,
      lastVisitedTabIndex: lastVisitedTabIndex ?? this.lastVisitedTabIndex,
      searchQueries: searchQueries ?? this.searchQueries,
    );
  }

  bool get hasSelectedItems =>
      selectedFoods.values.any((isSelected) => isSelected);

  @override
  List<Object?> get props => [
        loadedPages,
        availableCategories,
        allCategoryProducts,
        filteredCategoryProducts,
        selectedFoods,
        gramsPerFood,
        showOnlySelected,
        lastVisitedTabIndex,
        searchQueries,
      ];
}
