import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../assets/app_assets.dart';
import '../../providers/user_recipe_providers.dart';
import '../../motion/app_pressable.dart';
import '../../motion/app_reveal.dart';
import '../../providers/recipe_providers.dart';
import '../../shared/widgets/recipe_tile.dart';
import '../../shared/widgets/studio_shell.dart';
import '../../shared/widgets/tinted_block.dart';
import '../../theme/app_colors.dart';

class SavedScreen extends ConsumerWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final savedIds = ref.watch(savedIdsProvider);
    final savedRecipes = ref.watch(allRecipesProvider)
        .where((r) => savedIds.contains(r.id))
        .toList();

    final byCategory = <String, int>{};
    for (final r in savedRecipes) {
      for (final c in r.categories) {
        byCategory[c] = (byCategory[c] ?? 0) + 1;
      }
    }
    final categoryRows = byCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return StudioShell(
      tab: StudioTab.saved,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          AppReveal(
            child: Text(
              'Your Recipe Box',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 6),
          AppReveal(
            index: 1,
            child: Text(
              'Save and organize favourites — open them anywhere.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: colors.muted),
            ),
          ),
          const SizedBox(height: 18),
          AppReveal(
            index: 2,
            child: TintedBlock(
              tint: colors.primaryContainer,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.icBookmarkFilled,
                    width: 22,
                    height: 22,
                    colorFilter: ColorFilter.mode(
                      colors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Saved Recipes',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    '${savedRecipes.length}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (savedRecipes.isEmpty)
            AppReveal(
              index: 3,
              child: TintedBlock(
                tint: colors.secondaryContainer,
                child: Column(
                  children: [
                    Text(
                      'Your box is empty',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap SAVE on any recipe to keep it here.',
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: colors.muted),
                    ),
                    const SizedBox(height: 14),
                    OutlinedButton(
                      onPressed: () => context.go('/discover'),
                      child: const Text('EXPLORE RECIPES'),
                    ),
                  ],
                ),
              ),
            )
          else ...[
            ...savedRecipes.asMap().entries.map((e) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TintedBlock(
                  tint: e.key.isEven
                      ? colors.secondaryContainer
                      : colors.tertiaryContainer,
                  padding: EdgeInsets.zero,
                  child: RecipeRowTile(recipe: e.value, index: e.key),
                ),
              );
            }),
            const SizedBox(height: 20),
            AppReveal(
              index: 8,
              child: Text(
                'Browse by shelf',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 10),
            ...categoryRows.take(8).toList().asMap().entries.map((e) {
              final cat = e.value.key;
              final count = e.value.value;
              final sample = savedRecipes.firstWhere(
                (r) => r.categories.contains(cat),
              );
              return AppPressable(
                onTap: () =>
                    context.push('/search?q=${Uri.encodeComponent(cat)}'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          sample.image,
                          width: 44,
                          height: 44,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          cat,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      Text(
                        '$count',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: colors.muted),
                      ),
                      Icon(Icons.chevron_right, color: colors.muted),
                    ],
                  ),
                ),
              );
            }),
          ],
          const SizedBox(height: 16),
          AppReveal(
            index: 12,
            child: AppPressable(
              onTap: () => context.push('/grocery'),
              child: TintedBlock(
                tint: colors.chipPeach,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.navGrocery,
                      width: 22,
                      height: 22,
                      colorFilter: ColorFilter.mode(
                        colors.ink,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Open grocery list',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Icon(Icons.chevron_right, color: colors.muted),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
