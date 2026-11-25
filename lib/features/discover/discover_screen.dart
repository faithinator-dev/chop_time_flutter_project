import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/recipe_catalog.dart';
import '../../models/recipe.dart';
import '../../motion/app_pressable.dart';
import '../../motion/app_reveal.dart';
import '../../providers/recipe_providers.dart';
import '../../shared/widgets/recipe_tile.dart';
import '../../shared/widgets/studio_shell.dart';
import '../../shared/widgets/tinted_block.dart';
import '../../theme/app_colors.dart';

class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({super.key});

  Color _tintFor(AppColors colors, int tint) {
    switch (tint) {
      case 0:
        return colors.chipSage;
      case 2:
        return colors.chipButter;
      default:
        return colors.chipPeach;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final collections = ref.watch(collectionsProvider);

    return StudioShell(
      tab: StudioTab.discover,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          AppReveal(
            child: Text(
              'Collections',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 6),
          AppReveal(
            index: 1,
            child: Text(
              'Curated menus from our editors',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: colors.muted),
            ),
          ),
          const SizedBox(height: 18),
          ...collections.asMap().entries.map((entry) {
            final i = entry.key;
            final c = entry.value;
            final recipes = RecipeCatalog.inCollection(c.id);
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: AppReveal(
                index: i + 2,
                child: AppPressable(
                  onTap: () => context.push('/collection/${c.id}'),
                  child: TintedBlock(
                    tint: _tintFor(colors, c.tint),
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          c.subtitle,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: colors.muted),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          height: 72,
                          child: Row(
                            children: [
                              for (
                                var r = 0;
                                r < recipes.take(4).length;
                                r++
                              ) ...[
                                if (r > 0) const SizedBox(width: 8),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.asset(
                                      recipes[r].image,
                                      height: 72,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          AppReveal(
            index: 6,
            child: Text(
              'Browse by meal',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: RecipeCatalog.mealTypes
                .take(12)
                .toList()
                .asMap()
                .entries
                .map((e) {
                  final tint = e.key % 3 == 0
                      ? colors.chipSage
                      : e.key % 3 == 1
                      ? colors.chipPeach
                      : colors.chipButter;
                  return AppPressable(
                    onTap: () => context.push(
                      '/search?q=${Uri.encodeComponent(e.value)}',
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: tint,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        e.value,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  );
                })
                .toList(),
          ),
        ],
      ),
    );
  }
}

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({super.key, required this.collectionId});

  final String collectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final collection = RecipeCatalog.collections.firstWhere(
      (c) => c.id == collectionId,
      orElse: () => RecipeCatalog.collections.first,
    );
    final recipes = RecipeCatalog.inCollection(collection.id);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(
          collection.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.62,
        ),
        itemCount: recipes.length,
        itemBuilder: (context, i) {
          final Recipe recipe = recipes[i];
          return RecipeGridTile(
            recipe: recipe,
            index: i,
            tint: i.isEven
                ? colors.tertiaryContainer
                : colors.secondaryContainer,
          );
        },
      ),
    );
  }
}
