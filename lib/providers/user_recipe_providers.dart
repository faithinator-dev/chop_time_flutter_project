import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/recipe_catalog.dart';
import '../data/user_recipe_store.dart';
import '../models/recipe.dart';

final userRecipeStoreProvider = Provider<UserRecipeStore>(
  (ref) => UserRecipeStore(),
);

final userRecipesProvider =
    StateNotifierProvider<UserRecipesNotifier, AsyncValue<List<Recipe>>>((ref) {
      return UserRecipesNotifier(ref.read(userRecipeStoreProvider));
    });

class UserRecipesNotifier extends StateNotifier<AsyncValue<List<Recipe>>> {
  UserRecipesNotifier(this._store) : super(const AsyncLoading()) {
    load();
  }

  final UserRecipeStore _store;

  Future<void> load() async {
    try {
      state = AsyncData(await _store.load());
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> add(Recipe recipe) async {
    final next = [...?state.valueOrNull, recipe];
    await _store.save(next);
    state = AsyncData(next);
  }

  Future<void> update(Recipe recipe) async {
    final next = [
      for (final current in state.valueOrNull ?? <Recipe>[])
        if (current.id == recipe.id) recipe else current,
    ];
    await _store.save(next);
    state = AsyncData(next);
  }

  Future<void> remove(String id) async {
    final next = (state.valueOrNull ?? <Recipe>[])
        .where((recipe) => recipe.id != id)
        .toList();
    await _store.save(next);
    state = AsyncData(next);
  }
}

final allRecipesProvider = Provider<List<Recipe>>((ref) {
  final userRecipes = ref.watch(userRecipesProvider).valueOrNull ?? const <Recipe>[];
  return [...RecipeCatalog.all, ...userRecipes];
});

final recipeByIdProvider = Provider.family<Recipe?, String>((ref, id) {
  final userRecipes = ref.watch(userRecipesProvider).valueOrNull ?? const [];
  for (final recipe in userRecipes) {
    if (recipe.id == id) return recipe;
  }
  try {
    return RecipeCatalog.all.firstWhere((recipe) => recipe.id == id);
  } catch (_) {
    return null;
  }
});
