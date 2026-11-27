import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../assets/app_assets.dart';
import '../../data/recipe_catalog.dart';
import '../../motion/app_pressable.dart';
import '../../motion/app_reveal.dart';
import '../../providers/recipe_providers.dart';
import '../../providers/user_recipe_providers.dart';
import '../../shared/widgets/tinted_block.dart';
import '../../theme/app_chrome.dart';
import '../../theme/app_colors.dart';

class GroceryListScreen extends ConsumerStatefulWidget {
  const GroceryListScreen({super.key});

  @override
  ConsumerState<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends ConsumerState<GroceryListScreen> {
  final Set<String> _expanded = {'chili'};

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final grocery = ref.watch(groceryProvider);
    final allRecipes = ref.watch(allRecipesProvider);
    final entries = grocery.entries.toList();

    return ChromeScope(
      top: colors.surface,
      bottom: colors.background,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          title: const Text('Your Grocery List'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppAssets.icShare,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(colors.ink, BlendMode.srcIn),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Edit',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
        body: entries.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppReveal(
                        child: Text(
                          'List is empty',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Open a recipe and add its ingredients here.',
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: colors.muted),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () => context.go('/home'),
                        child: const Text('BROWSE RECIPES'),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final recipeId = entries[index].key;
                  final ingredients = entries[index].value.toList();
                  final recipe = allRecipes.firstWhere(
                    (item) => item.id == recipeId,
                    orElse: () => RecipeCatalog.byId(recipeId),
                  );
                  final open = _expanded.contains(recipeId);

                  return AppReveal(
                    index: index,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TintedBlock(
                        tint: colors.secondaryContainer,
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            AppPressable(
                              onTap: () {
                                setState(() {
                                  if (open) {
                                    _expanded.remove(recipeId);
                                  } else {
                                    _expanded.add(recipeId);
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        recipe.image,
                                        width: 52,
                                        height: 52,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, _, _) => Container(
                                          width: 52,
                                          height: 52,
                                          color: colors.surfaceContainer,
                                          child: const Icon(Icons.restaurant),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            recipe.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            recipe.yieldText,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(color: colors.muted),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      open
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      color: colors.muted,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (open)
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: colors.surface.withValues(alpha: 0.7),
                                  borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(22),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    for (final ingredient in ingredients)
                                      Dismissible(
                                        key: ValueKey('$recipeId-$ingredient'),
                                        direction: DismissDirection.endToStart,
                                        background: Container(
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.only(
                                            right: 20,
                                          ),
                                          color: colors.danger,
                                          child: Text(
                                            'Delete',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                  color: colors.onPrimary,
                                                ),
                                          ),
                                        ),
                                        onDismissed: (_) {
                                          ref
                                              .read(groceryProvider.notifier)
                                              .removeIngredient(
                                                recipeId,
                                                ingredient,
                                              );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color: colors.line,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            ingredient,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
