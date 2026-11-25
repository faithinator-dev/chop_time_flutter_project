import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/recipe_catalog.dart';
import '../models/recipe.dart';

final recipesProvider = Provider<List<Recipe>>((ref) => RecipeCatalog.all);

final recipeOfTheDayProvider = Provider<Recipe>((ref) {
  return RecipeCatalog.byId(RecipeCatalog.recipeOfTheDayId);
});

final collectionsProvider = Provider<List<RecipeCollection>>(
  (ref) => RecipeCatalog.collections,
);

final savedIdsProvider = StateNotifierProvider<SavedIdsNotifier, Set<String>>((
  ref,
) {
  return SavedIdsNotifier({'salmon', 'chili', 'cake', 'avocado', 'pasta'});
});

class SavedIdsNotifier extends StateNotifier<Set<String>> {
  SavedIdsNotifier(super.state);

  bool isSaved(String id) => state.contains(id);

  void toggle(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }
}

final groceryProvider =
    StateNotifierProvider<GroceryNotifier, Map<String, Set<String>>>((ref) {
      return GroceryNotifier({
        'chili': {
          '1 red onion or shallot, thinly sliced',
          'grapeseed oil',
          '1 teaspoon dried oregano',
          '2 (15-ounce) cans beans, drained',
          'Fresh cilantro, diced avocado and sour cream, for garnish (optional)',
        },
        'shabu': {
          '1 piece dried kombu',
          '2-inch piece ginger, sliced',
          '8 ounces mixed mushrooms',
        },
        'pie': {'2 cups crushed pretzels', '1 pound fresh strawberries'},
      });
    });

class GroceryNotifier extends StateNotifier<Map<String, Set<String>>> {
  GroceryNotifier(super.state);

  void addRecipe(Recipe recipe) {
    final next = Map<String, Set<String>>.from(state);
    next[recipe.id] = recipe.ingredients
        .map((i) => '${i.amount} ${i.name}'.trim())
        .toSet();
    state = next;
  }

  void removeIngredient(String recipeId, String ingredient) {
    final current = state[recipeId];
    if (current == null) return;
    final nextSet = {...current}..remove(ingredient);
    final next = Map<String, Set<String>>.from(state);
    if (nextSet.isEmpty) {
      next.remove(recipeId);
    } else {
      next[recipeId] = nextSet;
    }
    state = next;
  }

  void removeRecipe(String recipeId) {
    final next = Map<String, Set<String>>.from(state)..remove(recipeId);
    state = next;
  }
}

final cookChecksProvider =
    StateNotifierProvider.family<CookChecksNotifier, Set<int>, String>(
      (ref, recipeId) => CookChecksNotifier(),
    );

class CookChecksNotifier extends StateNotifier<Set<int>> {
  CookChecksNotifier() : super({});

  void toggle(int index) {
    if (state.contains(index)) {
      state = {...state}..remove(index);
    } else {
      state = {...state, index};
    }
  }
}
