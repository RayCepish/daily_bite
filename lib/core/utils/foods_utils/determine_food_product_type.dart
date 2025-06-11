class DeterminateFoodProductType {
  static const List<String> _prepKeywords = [
    'boiled',
    'canned',
    'dried',
    'fried',
    'frozen',
    'pasteurized',
    'raw',
  ];
  static const Map<String, String> _preparationEmojis = {
    'boiled': '💧',
    'canned': '🥫',
    'dried': '🔆',
    'fried': '♨️',
    'frozen': '❄️',
    'pasteurized': '🌡️',
    'raw': '🌀',
  };

  static const Map<String, String> _rawCategoryEmojis = {
    'meat': '🥩',
    'fish': '🐟',
    'vegetable': '🥦',
    'fruit': '🍎',
    'salad': '🥗',
  };

  List<String> getEmojis({
    String? preparation,
    required String category,
  }) {
    if (preparation == null || preparation.trim().isEmpty) {
      return [];
    }

    final prepLower = preparation.toLowerCase();
    final catLower = category.toLowerCase();

    final List<String> emojis = [];

    for (final key in _preparationEmojis.keys) {
      if (prepLower.contains(key)) {
        if (key == 'raw') {
          for (final catKey in _rawCategoryEmojis.keys) {
            if (catLower.contains(catKey)) {
              emojis.add(_rawCategoryEmojis[catKey]!);
              break;
            }
          }
          final isUniqueCategoryPresent = emojis.any(
            (emoji) => _rawCategoryEmojis.containsValue(emoji),
          );
          if (!isUniqueCategoryPresent) {
            emojis.add('🌀');
          }
        } else {
          emojis.add(_preparationEmojis[key]!);
        }
      }
    }

    return emojis.toSet().toList();
  }

  String cleanDescription(String description) {
    final parts = description.split(',').map((e) => e.trim()).toList();

    final resultParts = <String>[];

    for (final part in parts) {
      final lowerPart = part.toLowerCase();
      if (_prepKeywords.any((keyword) => lowerPart.contains(keyword))) {
        break;
      }
      resultParts.add(part);
    }

    return resultParts.join(', ');
  }
}
