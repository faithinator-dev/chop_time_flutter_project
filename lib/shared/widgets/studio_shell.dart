import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../assets/app_assets.dart';
import '../../motion/app_motion.dart';
import '../../motion/app_pressable.dart';
import '../../theme/app_chrome.dart';
import '../../theme/app_colors.dart';

enum StudioTab { forYou, discover, saved }

class StudioShell extends StatelessWidget {
  const StudioShell({super.key, required this.tab, required this.child});

  final StudioTab tab;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return ChromeScope(
      top: colors.surface,
      bottom: colors.background,
      child: Scaffold(
        backgroundColor: colors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: AppPressable(
                        onTap: () => context.push('/search'),
                        child: IgnorePointer(
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: 'What would you like to cook?',
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 14,
                                  right: 8,
                                ),
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
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    AppPressable(
                      onTap: () => context.push('/grocery'),
                      semanticLabel: 'Grocery list',
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          AppAssets.navGrocery,
                          width: 22,
                          height: 22,
                          colorFilter: ColorFilter.mode(
                            colors.ink,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _SectionChip(
                      label: 'For You',
                      selected: tab == StudioTab.forYou,
                      onTap: () => context.go('/home'),
                    ),
                    _SectionChip(
                      label: 'Discover',
                      selected: tab == StudioTab.discover,
                      onTap: () => context.go('/discover'),
                    ),
                    _SectionChip(
                      label: 'Saved',
                      selected: tab == StudioTab.saved,
                      onTap: () => context.go('/saved'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionChip extends StatelessWidget {
  const _SectionChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: AppPressable(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppMotion.sm,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? colors.ink : colors.secondaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: selected ? colors.onPrimary : colors.ink,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
