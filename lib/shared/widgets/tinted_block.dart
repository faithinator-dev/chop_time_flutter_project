import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class TintedBlock extends StatelessWidget {
  const TintedBlock({
    super.key,
    required this.child,
    this.tint,
    this.padding,
    this.radius = 22,
    this.onTap,
  });

  final Widget child;
  final Color? tint;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final box = DecoratedBox(
      decoration: BoxDecoration(
        color: tint ?? colors.secondaryContainer,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
    if (onTap == null) return box;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: box,
      ),
    );
  }
}
