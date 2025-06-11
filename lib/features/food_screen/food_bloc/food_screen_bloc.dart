import 'package:bloc/bloc.dart';
import 'package:daily_bite/core/utils/custom_try_catch.dart';
import 'package:daily_bite/models/food_products/food_category_model.dart';
import 'package:daily_bite/models/food_products/food_item_model.dart';
import 'package:daily_bite/services/api/food_api_service.dart';
import 'package:equatable/equatable.dart';

part 'food_screen_event.dart';
part 'food_screen_state.dart';

class FoodScreenBloc extends Bloc<FoodScreenEvent, FoodScreenState> {
  final FoodApiService _food;

  FoodScreenBloc(this._food) : super(FoodScreenState.initial()) {
    on<ChangeTabIndex>(_onChangeTabIndex);
    on<FetchCategories>(_onFetchCategories);
    on<LoadInitialCategories>(_onLoadInitialCategories);
    on<LoadNextCategoryPage>(_onLoadNextCategoryPage);
    on<SearchProductInCategory>(_onSearchProductInCategory);
    on<ToggleFoodSelection>(_onSelectFood);
    on<ChangeFoodGrams>(_onChangeGrams);
    on<ClearSelectedFoods>(_onClearSelectedFoods);
    on<ToggleShowOnlySelected>(_onShowOnlySelected);
    on<LoadFoodsByUsdaIds>(_onLoadFoodsByUsdaIds);
  }

  void _onChangeTabIndex(ChangeTabIndex event, Emitter<FoodScreenState> emit) {
    emit(state.copyWith(lastVisitedTabIndex: event.tabIndex));
  }

  Future<void> _onFetchCategories(
    FetchCategories event,
    Emitter<FoodScreenState> emit,
  ) async {
    await customTryCatch(
      showLoader: false,
      () async {
        final categories = await _food.fetchFoodCategories();
        emit(
          state.copyWith(availableCategories: categories),
        );
      },
    );
  }

  Future<void> _onLoadInitialCategories(
    LoadInitialCategories event,
    Emitter<FoodScreenState> emit,
  ) async {
    await customTryCatch(
      showLoader: true,
      () async {
        final updated = Map<String, List<FoodItemModel>>.from(
            state.filteredCategoryProducts);

        for (final cat in event.categories) {
          if (updated[cat]?.isNotEmpty ?? false) continue;

          final items = await _food.fetchFoodsByCategory(
            category: cat,
            page: 1,
          );

          updated[cat] = items.results;
        }

        emit(state.copyWith(filteredCategoryProducts: updated));
      },
    );
  }

  void _onLoadNextCategoryPage(
    LoadNextCategoryPage event,
    Emitter<FoodScreenState> emit,
  ) async {
    final alreadyLoaded = state.loadedPages[event.category] ?? {};

    if (alreadyLoaded.contains(event.page)) return;

    await customTryCatch(
      showLoader: true,
      () async {
        final newItems = await _food.fetchFoodsByCategory(
          category: event.category,
          page: event.page,
        );

        final currentItems =
            state.filteredCategoryProducts[event.category] ?? [];

        final updatedItems = [...currentItems, ...newItems.results];

        final updatedFiltered = Map<String, List<FoodItemModel>>.from(
          state.filteredCategoryProducts,
        );
        updatedFiltered[event.category] = updatedItems;

        final updatedLoaded = Map<String, Set<int>>.from(state.loadedPages);
        updatedLoaded[event.category] = {
          ...alreadyLoaded,
          event.page,
        };

        emit(
          state.copyWith(
            filteredCategoryProducts: updatedFiltered,
            loadedPages: updatedLoaded,
          ),
        );
      },
    );
  }

  Future<void> _onSearchProductInCategory(
    SearchProductInCategory event,
    Emitter<FoodScreenState> emit,
  ) async {
    final query = event.query.trim();
    final updatedSearchQueries = Map<String, String>.from(state.searchQueries);
    updatedSearchQueries[event.category] = query;

    await customTryCatch(showLoader: false, () async {
      final response = await _food.fetchFoodsByCategory(
        category: event.category,
        page: 1,
        searchQuery: query,
      );

      final updatedFiltered = Map<String, List<FoodItemModel>>.from(
        state.filteredCategoryProducts,
      );
      updatedFiltered[event.category] = response.results;

      emit(state.copyWith(
        filteredCategoryProducts: updatedFiltered,
        searchQueries: updatedSearchQueries,
      ));
    });
  }

  void _onSelectFood(
    ToggleFoodSelection event,
    Emitter<FoodScreenState> emit,
  ) {
    final updatedSelection = Map<String, bool>.from(state.selectedFoods);
    final updatedGrams = Map<String, double>.from(state.gramsPerFood);

    updatedSelection[event.itemName] = event.isSelected;

    if (!event.isSelected) {
      updatedGrams[event.itemName] = 100;
    }

    emit(state.copyWith(
      selectedFoods: updatedSelection,
      gramsPerFood: updatedGrams,
    ));
  }

  void _onChangeGrams(
    ChangeFoodGrams event,
    Emitter<FoodScreenState> emit,
  ) {
    final updatedGrams = Map<String, double>.from(state.gramsPerFood);
    updatedGrams[event.itemName] = event.grams;

    emit(state.copyWith(gramsPerFood: updatedGrams));
  }

  void _onClearSelectedFoods(
    ClearSelectedFoods event,
    Emitter<FoodScreenState> emit,
  ) {
    final clearedSelected = <String, bool>{};
    final resetGrams = <String, double>{};

    final allNames = {
      ...state.selectedFoods.keys,
      ...state.gramsPerFood.keys,
    };

    for (final name in allNames) {
      clearedSelected[name] = false;
      resetGrams[name] = 100;
    }

    emit(
      state.copyWith(
        selectedFoods: clearedSelected,
        gramsPerFood: resetGrams,
        showOnlySelected: false,
      ),
    );
  }

  void _onShowOnlySelected(
    ToggleShowOnlySelected event,
    Emitter<FoodScreenState> emit,
  ) {
    emit(
      state.copyWith(
        showOnlySelected: !state.showOnlySelected,
      ),
    );
  }

  Future<void> _onLoadFoodsByUsdaIds(
    LoadFoodsByUsdaIds event,
    Emitter<FoodScreenState> emit,
  ) async {
    await customTryCatch(showLoader: true, () async {
      final selected = Map<String, bool>.from(state.selectedFoods);
      final grams = Map<String, double>.from(state.gramsPerFood);
      final updated =
          Map<String, List<FoodItemModel>>.from(state.filteredCategoryProducts);

      final foodIds = event.items.map((e) => e.foodId).toList();
      final responseFoods = await _food.fetchFoodsByUsdaIds(foodIds);

      for (final food in responseFoods) {
        final matching = event.items.firstWhere(
          (pre) => pre.foodId == food.foodId,
          orElse: () => FoodItemModel.empty(),
        );

        selected[food.description] = true;
        grams[food.description] = matching.grams;

        final category = food.category ?? 'Uncategorized';
        updated.putIfAbsent(category, () => []);
        updated[category]!.add(food);
      }

      emit(state.copyWith(
        selectedFoods: selected,
        gramsPerFood: grams,
        filteredCategoryProducts: updated,
      ));
    });
  }
}
