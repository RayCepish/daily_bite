class FoodCategoryModel {
  final List<String> categories;
  final List<String> preparations;

  FoodCategoryModel({
    required this.categories,
    required this.preparations,
  });

  factory FoodCategoryModel.fromJson(Map<String, dynamic> json) {
    return FoodCategoryModel(
      categories: List<String>.from(json['categories'] ?? []),
      preparations: List<String>.from(json['preparations'] ?? []),
    );
  }
}
