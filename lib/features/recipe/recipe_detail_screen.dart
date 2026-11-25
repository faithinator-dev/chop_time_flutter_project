import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../assets/app_assets.dart';
import '../../data/recipe_catalog.dart';
import '../../motion/app_pressable.dart';
import '../../motion/app_reveal.dart';
import '../../providers/recipe_providers.dart';
import '../../shared/widgets/save_bookmark_button.dart';
import '../../theme/app_chrome.dart';
import '../../theme/app_colors.dart';

class RecipeDetailScreen extends ConsumerWidget {
  const RecipeDetailScreen({super.key, required this.recipeId});

  final String recipeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final recipe = RecipeCatalog.byId(recipeId);
    final saved = ref.watch(savedIdsProvider).contains(recipe.id);

    return ChromeScope(
      top: colors.surface,
      bottom: colors.surface,
      child: Scaffold(
        backgroundColor: colors.background,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 320,
                  backgroundColor: colors.surface,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        AppAssets.icShare,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          colors.ink,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(recipe.image, fit: BoxFit.cover),
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: SaveBookmarkButton(
                            saved: saved,
                            onToggle: () => ref
                                .read(savedIdsProvider.notifier)
                                .toggle(recipe.id),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppReveal(
                          child: Text(
                            recipe.title,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        const SizedBox(height: 10),
                        AppReveal(
                          index: 1,
                          child: Text(
                            recipe.author.toUpperCase(),
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(letterSpacing: 1.4),
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppReveal(
                          index: 2,
                          child: Row(
                            children: [
                              _Meta(label: 'YIELD', value: recipe.yieldText),
                              const SizedBox(width: 28),
                              _Meta(label: 'TIME', value: recipe.timeText),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        AppReveal(
                          index: 3,
                          child: Text(
                            recipe.blurb,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  height: 1.5,
                                  color: colors.ink.withValues(alpha: 0.85),
                                ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        AppReveal(
                          index: 4,
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: recipe.categories.map((c) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: colors.chipSage,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Text(
                                  c,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 28),
                        AppReveal(
                          index: 5,
                          child: Text(
                            'Ingredients preview',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...recipe.ingredients
                            .take(5)
                            .toList()
                            .asMap()
                            .entries
                            .map((e) {
                              return AppReveal(
                                index: 6 + e.key,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.value.amount,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          e.value.name,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        if (recipe.ingredients.length > 5)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              '+ ${recipe.ingredients.length - 5} more in cook mode',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: colors.muted),
                            ),
                          ),
                        const SizedBox(height: 20),
                        AppReveal(
                          index: 12,
                          child: AppPressable(
                            onTap: () {
                              ref
                                  .read(groceryProvider.notifier)
                                  .addRecipe(recipe);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Added to grocery list'),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: colors.secondaryContainer,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.navGrocery,
                                    width: 20,
                                    height: 20,
                                    colorFilter: ColorFilter.mode(
                                      colors.ink,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Add ingredients to grocery list',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 24,
              child: SafeArea(
                top: false,
                child: AppReveal(
                  style: RevealStyle.sheet,
                  child: OutlinedButton(
                    onPressed: () => context.push('/cook/${recipe.id}'),
                    child: const Text('START COOKING'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
