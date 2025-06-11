import 'package:daily_bite/core/constants/app_const_service.dart';
import 'package:daily_bite/models/food_products/food_category_model.dart';
import 'package:daily_bite/models/food_products/food_item_model.dart';
import 'package:daily_bite/models/food_products/food_items_response_model.dart';
import 'package:daily_bite/services/setup_dependencies.dart';
import 'package:dio/dio.dart';

class FoodApiService {
  final String baseUrl = AppConstService.baseUrl;
  final dio = getIt<Dio>();

  Future<FoodCategoryModel> fetchFoodCategories() async {
    final response = await dio.get(
      '$baseUrl/api/foods/metadata/',
    );

    return FoodCategoryModel.fromJson(response.data);
  }

  Future<FoodItemsResponseModel> fetchFoodsByCategory({
    required String category,
    required int page,
    String? searchQuery,
    int pageSize = 10,
  }) async {
    final response = await dio.get(
      '$baseUrl/api/foods/',
      queryParameters: {
        'category': category,
        'page': page,
        'page_size': pageSize,
        'name': searchQuery,
      },
    );

    return FoodItemsResponseModel.fromJson(response.data);
  }

  Future<List<FoodItemModel>> fetchFoodsByUsdaIds(List<int> foodIds) async {
    final response = await dio.get(
      '$baseUrl/api/foods/by-usda-ids',
      queryParameters: {
        'food_id': foodIds,
      },
    );

    final data = response.data['results'] as List;
    return data.map((e) => FoodItemModel.fromJson(e)).toList();
  }
}
