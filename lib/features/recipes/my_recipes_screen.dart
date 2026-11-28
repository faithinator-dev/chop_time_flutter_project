import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../motion/app_reveal.dart';
import '../../providers/user_recipe_providers.dart';
import '../../shared/widgets/recipe_tile.dart';
import '../../theme/app_colors.dart';

class MyRecipesScreen extends ConsumerWidget {
  const MyRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final recipesState = ref.watch(userRecipesProvider);
    final recipes = recipesState.valueOrNull ?? const [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Recipes',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      'Your personal kitchen collection',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: colors.muted),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 96,
                child: FilledButton.icon(
                  onPressed: () => context.push('/recipe-editor'),
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: recipesState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : recipes.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.menu_book_outlined,
                          size: 54,
                          color: colors.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your kitchen starts here',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Create your first recipe and keep your own cooking notes in one place.',
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: colors.muted),
                        ),
                        const SizedBox(height: 18),
                        FilledButton.icon(
                          onPressed: () => context.push('/recipe-editor'),
                          icon: const Icon(Icons.add),
                          label: const Text('Create a recipe'),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                  children: [
                    AppReveal(
                      child: Text(
                        '${recipes.length} recipe${recipes.length == 1 ? '' : 's'} made by you',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: colors.muted),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...recipes.asMap().entries.map((entry) {
                      final recipe = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Dismissible(
                          key: ValueKey(recipe.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 22),
                            decoration: BoxDecoration(
                              color: colors.danger,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.delete_outline,
                              color: colors.onPrimary,
                            ),
                          ),
                          confirmDismiss: (_) async =>
                              await showDialog<bool>(
                                context: context,
                                builder: (dialogContext) => AlertDialog(
                                  title: const Text('Delete recipe?'),
                                  content: Text(
                                    '“${recipe.title}” will be removed from My Recipes.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(dialogContext, false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(dialogContext, true),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              ) ??
                              false,
                          onDismissed: (_) => ref
                              .read(userRecipesProvider.notifier)
                              .remove(recipe.id),
                          child: RecipeRowTile(
                            recipe: recipe,
                            index: entry.key,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
        ),
      ],
    );
  }
}
