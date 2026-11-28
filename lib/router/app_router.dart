import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/cook/cook_mode_screen.dart';
import '../features/discover/discover_screen.dart';
import '../features/grocery/grocery_list_screen.dart';
import '../features/home/home_screen.dart';
import '../features/recipe/recipe_detail_screen.dart';
import '../features/recipes/my_recipes_screen.dart';
import '../features/recipes/recipe_editor_screen.dart';
import '../features/saved/saved_screen.dart';
import '../features/search/search_screen.dart';
import '../features/splash/splash_screen.dart';
import '../shared/widgets/studio_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) =>
            CupertinoPage(key: state.pageKey, child: const SplashScreen()),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) =>
            CupertinoPage(key: state.pageKey, child: const HomeScreen()),
      ),
      GoRoute(
        path: '/discover',
        pageBuilder: (context, state) =>
            CupertinoPage(key: state.pageKey, child: const DiscoverScreen()),
      ),
      GoRoute(
        path: '/my-recipes',
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: StudioShell(tab: StudioTab.myRecipes, child: const MyRecipesScreen()),
        ),
      ),
      GoRoute(
        path: '/recipe-editor',
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: RecipeEditorScreen(
            recipeId: state.uri.queryParameters['id'],
          ),
        ),
      ),
      GoRoute(
        path: '/saved',
        pageBuilder: (context, state) =>
            CupertinoPage(key: state.pageKey, child: const SavedScreen()),
      ),
      GoRoute(
        path: '/search',
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: SearchScreen(
            initialQuery: state.uri.queryParameters['q'] ?? '',
          ),
        ),
      ),
      GoRoute(
        path: '/recipe/:id',
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: RecipeDetailScreen(
            recipeId: state.pathParameters['id'] ?? 'squash-chickpeas',
          ),
        ),
      ),
      GoRoute(
        path: '/cook/:id',
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: CookModeScreen(
            recipeId: state.pathParameters['id'] ?? 'squash-chickpeas',
          ),
        ),
      ),
      GoRoute(
        path: '/grocery',
        pageBuilder: (context, state) =>
            CupertinoPage(key: state.pageKey, child: const GroceryListScreen()),
      ),
      GoRoute(
        path: '/collection/:id',
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: CollectionScreen(
            collectionId: state.pathParameters['id'] ?? 'one-pot',
          ),
        ),
      ),
    ],
  );
});
