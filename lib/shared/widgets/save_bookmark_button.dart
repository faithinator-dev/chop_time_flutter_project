import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../assets/app_assets.dart';
import '../../motion/app_motion.dart';
import '../../motion/app_pressable.dart';
import '../../theme/app_colors.dart';

class SaveBookmarkButton extends StatelessWidget {
  const SaveBookmarkButton({
    super.key,
    required this.saved,
    required this.onToggle,
    this.compact = false,
  });

  final bool saved;
  final VoidCallback onToggle;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    if (compact) {
      return AppPressable(
        onTap: onToggle,
        semanticLabel: saved ? 'Unsave recipe' : 'Save recipe',
        child: SvgPicture.asset(
          saved ? AppAssets.icBookmarkFilled : AppAssets.icBookmark,
          width: 22,
          height: 22,
          colorFilter: ColorFilter.mode(
            saved ? colors.primary : colors.ink,
            BlendMode.srcIn,
          ),
        ),
      );
    }

    return AppPressable(
      onTap: onToggle,
      semanticLabel: saved ? 'Saved' : 'Save',
      child: AnimatedContainer(
        duration: AppMotion.md,
        curve: AppMotion.standard,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: saved ? colors.primary : colors.ink,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              saved ? AppAssets.icBookmarkFilled : AppAssets.icBookmark,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(colors.onPrimary, BlendMode.srcIn),
            ),
            const SizedBox(width: 8),
            Text(
              saved ? 'SAVED' : 'SAVE',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colors.onPrimary,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
