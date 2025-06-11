import 'package:daily_bite/models/food_products/food_item_model.dart';

class FoodItemsResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final List<FoodItemModel> results;
  FoodItemsResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory FoodItemsResponseModel.fromJson(Map<String, dynamic> json) {
    return FoodItemsResponseModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((item) => FoodItemModel.fromJson(item))
          .toList(),
    );
  }
}
