import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/recipe.dart';
import '../../motion/app_pressable.dart';
import '../../motion/app_reveal.dart';
import '../../providers/recipe_providers.dart';
import '../../theme/app_colors.dart';
import 'save_bookmark_button.dart';
import 'tinted_block.dart';

class RecipeGridTile extends ConsumerWidget {
  const RecipeGridTile({
    super.key,
    required this.recipe,
    this.index = 0,
    this.tint,
  });

  final Recipe recipe;
  final int index;
  final Color? tint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final saved = ref.watch(savedIdsProvider).contains(recipe.id);

    return AppReveal(
      index: index,
      child: AppPressable(
        onTap: () => context.push('/recipe/${recipe.id}'),
        child: TintedBlock(
          tint: tint ?? colors.secondaryContainer,
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    recipe.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        ColoredBox(color: colors.surfaceContainer),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            recipe.author,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colors.muted),
                          ),
                        ),
                        SaveBookmarkButton(
                          saved: saved,
                          compact: true,
                          onToggle: () => ref
                              .read(savedIdsProvider.notifier)
                              .toggle(recipe.id),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeRowTile extends ConsumerWidget {
  const RecipeRowTile({
    super.key,
    required this.recipe,
    this.index = 0,
    this.trailingCount,
  });

  final Recipe recipe;
  final int index;
  final String? trailingCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);

    return AppReveal(
      index: index,
      child: AppPressable(
        onTap: () => context.push('/recipe/${recipe.id}'),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Image.asset(
                    recipe.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        ColoredBox(color: colors.surfaceContainer),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      trailingCount ?? recipe.yieldText,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: colors.muted),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colors.muted),
            ],
          ),
        ),
      ),
    );
  }
}
