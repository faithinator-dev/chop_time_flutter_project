import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../assets/app_assets.dart';
import '../../data/recipe_catalog.dart';
import '../../motion/app_motion.dart';
import '../../motion/app_pressable.dart';
import '../../motion/app_reveal.dart';
import '../../motion/app_skeleton.dart';
import '../../shared/widgets/recipe_tile.dart';
import '../../theme/app_chrome.dart';
import '../../theme/app_colors.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key, this.initialQuery = ''});

  final String initialQuery;

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;
  String _query = '';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _query = widget.initialQuery;
    _controller = TextEditingController(text: widget.initialQuery);
    if (_query.isNotEmpty) {
      _simulateLoad();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _simulateLoad() async {
    setState(() => _loading = true);
    await Future<void>.delayed(AppMotion.lg);
    if (mounted) setState(() => _loading = false);
  }

  void _setQuery(String value) {
    setState(() => _query = value);
    _simulateLoad();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final results = RecipeCatalog.search(_query);

    return ChromeScope(
      top: colors.surface,
      bottom: colors.background,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('Search'),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            AppReveal(
              child: TextField(
                controller: _controller,
                autofocus: widget.initialQuery.isEmpty,
                textInputAction: TextInputAction.search,
                onChanged: _setQuery,
                onSubmitted: _setQuery,
                decoration: InputDecoration(
                  hintText: 'What would you like to cook?',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 14, right: 8),
                    child: SvgPicture.asset(
                      AppAssets.navSearch,
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        colors.muted,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                  ),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _controller.clear();
                            _setQuery('');
                          },
                        ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            if (_query.isEmpty) ...[
              AppReveal(
                index: 1,
                child: Text(
                  'SUGGESTIONS',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: RecipeCatalog.suggestions.asMap().entries.map((e) {
                  final tint = e.key % 3 == 0
                      ? colors.chipSage
                      : e.key % 3 == 1
                      ? colors.chipPeach
                      : colors.chipButter;
                  return AppPressable(
                    onTap: () {
                      _controller.text = e.value;
                      _setQuery(e.value);
                    },
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
                }).toList(),
              ),
              const SizedBox(height: 26),
              AppReveal(
                index: 2,
                child: Text(
                  'MEAL TYPES',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: RecipeCatalog.mealTypes.map((meal) {
                  return AppPressable(
                    onTap: () {
                      _controller.text = meal;
                      _setQuery(meal);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: colors.chipPeach,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        meal,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ] else if (_loading) ...[
              for (var i = 0; i < 4; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      AppSkeleton(
                        width: 64,
                        height: 64,
                        radius: 12,
                        base: colors.surfaceContainer,
                        highlight: colors.surface,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppSkeleton(
                              width: double.infinity,
                              height: 14,
                              radius: 6,
                              base: colors.surfaceContainer,
                              highlight: colors.surface,
                            ),
                            const SizedBox(height: 8),
                            AppSkeleton(
                              width: 120,
                              height: 12,
                              radius: 6,
                              base: colors.surfaceContainer,
                              highlight: colors.surface,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ] else if (results.isEmpty) ...[
              AppReveal(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Text(
                        'No recipes matched',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try a meal type like Dinner or Pasta.',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: colors.muted),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Text(
                '${results.length} recipes',
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: colors.muted),
              ),
              const SizedBox(height: 12),
              ...results.asMap().entries.map(
                (e) => RecipeRowTile(recipe: e.value, index: e.key),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
