class AllowedFoodCategories {
  static const Set<String> allowedCategories = {
    "dairy",
    "fish",
    "fruits",
    "legumes",
    "meat",
    "nuts",
    "vegetables",
  };
  static const Map<String, String> _categoryLabels = {
    "dairy": "D&E Products",
    "fish": "Fish",
    "fruits": "Fruits",
    "legumes": "Legumes",
    "meat": "Meat",
    "nuts": "Nuts",
    "vegetables": "Vegetables",
  };

  String getLabel(String key) {
    return _categoryLabels[key] ?? key;
  }

  List<String> filterAllowed(List<String> categories) {
    return categories.where(allowedCategories.contains).toList();
  }
}
