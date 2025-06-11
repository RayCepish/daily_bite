import 'dart:convert';

import 'package:daily_bite/core/constants/app_const_service.dart';
import 'package:daily_bite/models/nutrition_model/nutrition_model.dart';
import 'package:daily_bite/models/recipe_models/calculated_recipe_nutrients_response.dart';
import 'package:daily_bite/models/recipe_models/ingredients_model.dart';
import 'package:daily_bite/models/recipe_models/recipe_items_response_model.dart';
import 'package:daily_bite/models/recipe_models/recipe_model.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:dio/dio.dart';

class RecipesApiService {
  final String baseUrl = AppConstService.baseUrl;
  final dio = getIt<Dio>();

  Future<RecipeItemsResponseModel> fetchRecipes({
    required int page,
    int pageSize = 10,
  }) async {
    final response = await dio.get(
      '$baseUrl/api/recipes/',
      queryParameters: {
        'page': page,
      },
    );

    if (response.data is List) {
      final List<RecipeModel> recipes = (response.data as List)
          .map((item) => RecipeModel.fromJson(item as Map<String, dynamic>))
          .toList();
      final json = jsonDecode(response.data) as Map<String, dynamic>;
      final totals = NutritionModel.fromJson(json['totals']);
      return RecipeItemsResponseModel(
        totals: totals,
        recipes: recipes,
      );
    } else {
      return RecipeItemsResponseModel.fromJson(
          response.data as Map<String, dynamic>);
    }
  }

  Future<NutritionModel> fetchNutritionTotals() async {
    final response = await dio.get('$baseUrl/api/recipes/');
    final data = response.data;

    return NutritionModel.fromJson(data['totals']);
  }

  Future<RecipeModel> getRecipeByID(int recipeId) async {
    final response = await dio.get(
      '$baseUrl/api/recipes/$recipeId/',
    );
    return RecipeModel.fromJson(response.data);
  }

  Future<CalculatedRecipeNutrientsResponse> getRecipeIngredients(
      List<IngredientsModel> recipesData) async {
    final data = recipesData
        .map((i) => {
              'food_id': i.foodId,
              'grams': i.grams,
            })
        .toList();

    final response = await dio.post(
      '$baseUrl/api/recipes/calculate-nutrition/',
      data: data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    return CalculatedRecipeNutrientsResponse.fromJson(response.data);
  }

  Future<void> createRecipe(RecipeModel recipe) async {
    final data = {
      'name': recipe.name,
      'description': recipe.description,
      'instruction': recipe.instruction,
      'ingredients': recipe.ingredients.map((e) => e.toJson()).toList(),
    };

    await dio.post(
      '$baseUrl/api/recipes/',
      data: data,
    );
  }

  Future<void> updateRecipe(RecipeModel recipe) async {
    final data = {
      'name': recipe.name,
      'description': recipe.description,
      'instruction': recipe.instruction,
      'ingredients': recipe.ingredients.map((e) => e.toJson()).toList(),
    };

    await dio.patch(
      '$baseUrl/api/recipes/${recipe.id}/',
      data: data,
    );
  }

  Future<void> addToFavorites(int recipeId) async {
    await dio.post(
      '$baseUrl/api/recipes/$recipeId/favorite/',
      data: {'recipe_id': recipeId},
    );
  }

  Future<void> removeFromFavorites(int recipeId) async {
    await dio.delete(
      '$baseUrl/api/recipes/$recipeId/favorite/',
      data: {'recipe_id': recipeId},
    );
  }

  Future<void> deleteRecipe(int id) async {
    await dio.delete(
      '$baseUrl/api/recipes/$id/',
    );
  }
}
