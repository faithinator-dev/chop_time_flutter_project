import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/recipe.dart';

class UserRecipeStore {
  static const _storageKey = 'choptime.user_recipes.v1';

  Future<List<Recipe>> load() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_storageKey);
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((item) => _recipeFromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> save(List<Recipe> recipes) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      _storageKey,
      jsonEncode(recipes.map(_recipeToJson).toList()),
    );
  }

  Map<String, dynamic> _recipeToJson(Recipe recipe) => {
    'id': recipe.id,
    'title': recipe.title,
    'author': recipe.author,
    'blurb': recipe.blurb,
    'image': recipe.image,
    'yieldText': recipe.yieldText,
    'timeText': recipe.timeText,
    'minutes': recipe.minutes,
    'categories': recipe.categories,
    'ingredients': recipe.ingredients
        .map((item) => {
              'amount': item.amount,
              'name': item.name,
              'section': item.section,
            })
        .toList(),
    'steps': recipe.steps
        .map((item) => {
              'number': item.number,
              'text': item.text,
              'minutes': item.minutes,
            })
        .toList(),
  };

  Recipe _recipeFromJson(Map<String, dynamic> json) => Recipe(
    id: json['id'] as String,
    title: json['title'] as String,
    author: json['author'] as String? ?? 'You',
    blurb: json['blurb'] as String? ?? '',
    image: json['image'] as String? ?? '',
    yieldText: json['yieldText'] as String? ?? '1 serving',
    timeText: json['timeText'] as String? ?? '',
    minutes: json['minutes'] as int? ?? 1,
    categories: (json['categories'] as List<dynamic>? ?? const [])
        .cast<String>(),
    ingredients: (json['ingredients'] as List<dynamic>? ?? const [])
        .map((item) {
          final value = item as Map<String, dynamic>;
          return RecipeIngredient(
            amount: value['amount'] as String? ?? '',
            name: value['name'] as String? ?? '',
            section: value['section'] as String? ?? 'Ingredients',
          );
        })
        .toList(),
    steps: (json['steps'] as List<dynamic>? ?? const [])
        .map((item) {
          final value = item as Map<String, dynamic>;
          return RecipeStep(
            number: value['number'] as int? ?? 1,
            text: value['text'] as String? ?? '',
            minutes: value['minutes'] as int?,
          );
        })
        .toList(),
  );
}
