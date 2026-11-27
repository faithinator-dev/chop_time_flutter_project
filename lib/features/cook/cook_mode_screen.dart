import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/user_recipe_providers.dart';
import '../../motion/app_pressable.dart';
import '../../motion/app_progress.dart';
import '../../motion/app_reveal.dart';
import '../../motion/app_success.dart';
import '../../providers/recipe_providers.dart';
import '../../theme/app_chrome.dart';
import '../../theme/app_colors.dart';

class CookModeScreen extends ConsumerStatefulWidget {
  const CookModeScreen({super.key, required this.recipeId});

  final String recipeId;

  @override
  ConsumerState<CookModeScreen> createState() => _CookModeScreenState();
}

class _CookModeScreenState extends ConsumerState<CookModeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final Set<int> _ingredientChecks = {};
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final recipe = ref.watch(recipeByIdProvider(widget.recipeId));
    if (recipe == null) {
      return Scaffold(
        backgroundColor: colors.background,
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final stepChecks = ref.watch(cookChecksProvider(recipe.id));
    final stepProgress = recipe.steps.isEmpty
        ? 0.0
        : stepChecks.length / recipe.steps.length;

    final sections = <String, List<int>>{};
    for (var i = 0; i < recipe.ingredients.length; i++) {
      final section = recipe.ingredients[i].section;
      sections.putIfAbsent(section, () => []).add(i);
    }

    return ChromeScope(
      top: colors.surface,
      bottom: colors.surface,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            onPressed: () => context.pop(),
          ),
          title: Text(
            recipe.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: TabBar(
              controller: _tabs,
              labelColor: colors.ink,
              unselectedLabelColor: colors.primary,
              indicatorColor: colors.ink,
              indicatorWeight: 2.5,
              labelStyle: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(letterSpacing: 1.2),
              tabs: const [
                Tab(text: 'INGREDIENTS'),
                Tab(text: 'PREPARATION'),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: AppSegmentBar(
                filled: stepChecks.length,
                total: recipe.steps.length,
                color: colors.primary,
                track: colors.line,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabs,
                children: [
                  ListView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                    children: [
                      for (final entry in sections.entries) ...[
                        AppReveal(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 10),
                            child: Text(
                              entry.key.toUpperCase(),
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(letterSpacing: 1.1),
                            ),
                          ),
                        ),
                        ...entry.value.map((index) {
                          final item = recipe.ingredients[index];
                          final checked = _ingredientChecks.contains(index);
                          return AppPressable(
                            onTap: () {
                              setState(() {
                                if (checked) {
                                  _ingredientChecks.remove(index);
                                } else {
                                  _ingredientChecks.add(index);
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppCheckCircle(
                                    checked: checked,
                                    size: 24,
                                    color: colors.primary,
                                    border: colors.outline,
                                    checkColor: colors.onPrimary,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: checked
                                                  ? colors.muted
                                                  : colors.ink,
                                              decoration: checked
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: item.amount,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          TextSpan(text: ' ${item.name}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ],
                  ),
                  ListView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                    children: [
                      if (_done)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Center(child: AppSuccess(size: 88)),
                        ),
                      ...recipe.steps.asMap().entries.map((e) {
                        final step = e.value;
                        final checked = stepChecks.contains(e.key);
                        return AppReveal(
                          index: e.key,
                          child: AppPressable(
                            onTap: () {
                              ref
                                  .read(cookChecksProvider(recipe.id).notifier)
                                  .toggle(e.key);
                              final next = {...stepChecks};
                              if (checked) {
                                next.remove(e.key);
                              } else {
                                next.add(e.key);
                              }
                              if (next.length == recipe.steps.length) {
                                setState(() => _done = true);
                              } else if (_done) {
                                setState(() => _done = false);
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: checked
                                    ? colors.tertiaryContainer
                                    : colors.secondaryContainer,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: checked
                                        ? colors.primary
                                        : colors.ink,
                                    foregroundColor: colors.onPrimary,
                                    child: Text(
                                      checked ? '✓' : '${step.number}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(color: colors.onPrimary),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          step.text,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: checked
                                                    ? colors.muted
                                                    : colors.ink,
                                              ),
                                        ),
                                        if (step.minutes != null) ...[
                                          const SizedBox(height: 8),
                                          Text(
                                            'About ${step.minutes} min',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(color: colors.muted),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 8),
                      Text(
                        'Progress ${(stepProgress * 100).round()}%',
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium?.copyWith(color: colors.muted),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
