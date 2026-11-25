import 'package:flutter/material.dart';

/// Recipe Studio palette — editorial white paper + warm red accent.
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.primary,
    required this.onPrimary,
    required this.primaryText,
    required this.secondary,
    required this.onSecondary,
    required this.tertiary,
    required this.primaryContainer,
    required this.secondaryContainer,
    required this.tertiaryContainer,
    required this.ink,
    required this.muted,
    required this.line,
    required this.outline,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.success,
    required this.warning,
    required this.danger,
    required this.chipSage,
    required this.chipPeach,
    required this.chipButter,
  });

  final Color background;
  final Color surface;
  final Color primary;
  final Color onPrimary;
  final Color primaryText;
  final Color secondary;
  final Color onSecondary;
  final Color tertiary;
  final Color primaryContainer;
  final Color secondaryContainer;
  final Color tertiaryContainer;
  final Color ink;
  final Color muted;
  final Color line;
  final Color outline;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color success;
  final Color warning;
  final Color danger;
  final Color chipSage;
  final Color chipPeach;
  final Color chipButter;

  static const light = AppColors(
    background: Color(0xFFFAFAF8),
    surface: Color(0xFFFFFFFF),
    primary: Color(0xFFC62828),
    onPrimary: Color(0xFFFFFFFF),
    primaryText: Color(0xFF121212),
    secondary: Color(0xFFF3EDE4),
    onSecondary: Color(0xFF121212),
    tertiary: Color(0xFFE8F0E6),
    primaryContainer: Color(0xFFFFEBEE),
    secondaryContainer: Color(0xFFF7F2EA),
    tertiaryContainer: Color(0xFFEFF5ED),
    ink: Color(0xFF121212),
    muted: Color(0xFF6B6B6B),
    line: Color(0xFFE8E4DE),
    outline: Color(0xFFD6D0C8),
    surfaceContainerLow: Color(0xFFF5F2EC),
    surfaceContainer: Color(0xFFEEE9E1),
    surfaceContainerHigh: Color(0xFFE4DED4),
    success: Color(0xFF2E7D32),
    warning: Color(0xFFED6C02),
    danger: Color(0xFFC62828),
    chipSage: Color(0xFFD7E5D4),
    chipPeach: Color(0xFFF5D9C8),
    chipButter: Color(0xFFF5E9B8),
  );

  static const dark = AppColors(
    background: Color(0xFF161412),
    surface: Color(0xFF1E1C19),
    primary: Color(0xFFE57373),
    onPrimary: Color(0xFF1A0000),
    primaryText: Color(0xFFF5F2EC),
    secondary: Color(0xFF3A342C),
    onSecondary: Color(0xFFF5F2EC),
    tertiary: Color(0xFF2A3328),
    primaryContainer: Color(0xFF4A1C1C),
    secondaryContainer: Color(0xFF2E2922),
    tertiaryContainer: Color(0xFF243020),
    ink: Color(0xFFF5F2EC),
    muted: Color(0xFFA39E96),
    line: Color(0xFF3A342C),
    outline: Color(0xFF4A443C),
    surfaceContainerLow: Color(0xFF221F1B),
    surfaceContainer: Color(0xFF2A2621),
    surfaceContainerHigh: Color(0xFF35302A),
    success: Color(0xFF81C784),
    warning: Color(0xFFFFB74D),
    danger: Color(0xFFEF9A9A),
    chipSage: Color(0xFF2A3328),
    chipPeach: Color(0xFF3A2A22),
    chipButter: Color(0xFF3A3420),
  );

  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>() ?? AppColors.light;
  }

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? primary,
    Color? onPrimary,
    Color? primaryText,
    Color? secondary,
    Color? onSecondary,
    Color? tertiary,
    Color? primaryContainer,
    Color? secondaryContainer,
    Color? tertiaryContainer,
    Color? ink,
    Color? muted,
    Color? line,
    Color? outline,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? success,
    Color? warning,
    Color? danger,
    Color? chipSage,
    Color? chipPeach,
    Color? chipButter,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryText: primaryText ?? this.primaryText,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      tertiary: tertiary ?? this.tertiary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      ink: ink ?? this.ink,
      muted: muted ?? this.muted,
      line: line ?? this.line,
      outline: outline ?? this.outline,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      chipSage: chipSage ?? this.chipSage,
      chipPeach: chipPeach ?? this.chipPeach,
      chipButter: chipButter ?? this.chipButter,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      primaryContainer: Color.lerp(
        primaryContainer,
        other.primaryContainer,
        t,
      )!,
      secondaryContainer: Color.lerp(
        secondaryContainer,
        other.secondaryContainer,
        t,
      )!,
      tertiaryContainer: Color.lerp(
        tertiaryContainer,
        other.tertiaryContainer,
        t,
      )!,
      ink: Color.lerp(ink, other.ink, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      line: Color.lerp(line, other.line, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      surfaceContainerLow: Color.lerp(
        surfaceContainerLow,
        other.surfaceContainerLow,
        t,
      )!,
      surfaceContainer: Color.lerp(
        surfaceContainer,
        other.surfaceContainer,
        t,
      )!,
      surfaceContainerHigh: Color.lerp(
        surfaceContainerHigh,
        other.surfaceContainerHigh,
        t,
      )!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      chipSage: Color.lerp(chipSage, other.chipSage, t)!,
      chipPeach: Color.lerp(chipPeach, other.chipPeach, t)!,
      chipButter: Color.lerp(chipButter, other.chipButter, t)!,
    );
  }
}
