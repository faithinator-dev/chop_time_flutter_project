import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/recipe_catalog.dart';
import '../../motion/app_pressable.dart';
import '../../motion/app_reveal.dart';
import '../../providers/recipe_providers.dart';
import '../../shared/widgets/recipe_tile.dart';
import '../../shared/widgets/save_bookmark_button.dart';
import '../../shared/widgets/studio_shell.dart';
import '../../shared/widgets/tinted_block.dart';
import '../../theme/app_colors.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final featured = ref.watch(recipeOfTheDayProvider);
    final saved = ref.watch(savedIdsProvider).contains(featured.id);
    final weeknight = RecipeCatalog.all
        .where((r) => r.minutes <= 35 && r.id != featured.id)
        .take(6)
        .toList();
    final desserts = RecipeCatalog.byCategory('Dessert');

    return StudioShell(
      tab: StudioTab.forYou,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          AppReveal(
            child: Text(
              'RECIPE OF THE DAY',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: colors.primary,
                letterSpacing: 1.6,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          AppReveal(
            index: 1,
            child: AppPressable(
              onTap: () => context.push('/recipe/${featured.id}'),
              child: TintedBlock(
                tint: colors.secondaryContainer,
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(22),
                          ),
                          child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: Image.asset(
                              featured.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12,
                          bottom: 12,
                          child: SaveBookmarkButton(
                            saved: saved,
                            onToggle: () => ref
                                .read(savedIdsProvider.notifier)
                                .toggle(featured.id),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            featured.title,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(height: 1.2),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            featured.author,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            featured.blurb,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: colors.muted, height: 1.45),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          AppReveal(
            index: 2,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Weeknight winners',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                AppPressable(
                  onTap: () => context.go('/discover'),
                  child: Text(
                    'See all',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: colors.primary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 280,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: weeknight.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                return SizedBox(
                  width: 180,
                  child: RecipeGridTile(
                    recipe: weeknight[i],
                    index: i,
                    tint: i.isEven
                        ? colors.tertiaryContainer
                        : colors.secondaryContainer,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 28),
          AppReveal(
            index: 3,
            child: Text(
              'Something sweet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 14),
          ...desserts.asMap().entries.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TintedBlock(
                tint: colors.chipButter,
                padding: EdgeInsets.zero,
                onTap: () => context.push('/recipe/${e.value.id}'),
                child: RecipeRowTile(recipe: e.value, index: e.key),
              ),
            );
          }),
        ],
      ),
    );
  }
}
