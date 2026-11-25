import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_studio/theme/app_colors.dart';

import '../motion/app_motion.dart';

class AppTheme {
  static const defaultMode = ThemeMode.light;

  static final SystemUiOverlayStyle systemUi = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.light.background,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: const Color(0x00000000),
  );

  static Widget withSystemUi(BuildContext context, Widget child) =>
      AnnotatedRegion<SystemUiOverlayStyle>(value: systemUi, child: child);

  static ThemeData light() => _build(AppColors.light, Brightness.light);

  static ThemeData dark() => _build(AppColors.dark, Brightness.dark);

  static ThemeData _build(AppColors colors, Brightness brightness) {
    final base = brightness == Brightness.light
        ? ThemeData.light(useMaterial3: true)
        : ThemeData.dark(useMaterial3: true);

    final serif = GoogleFonts.playfairDisplayTextTheme(base.textTheme);
    final sans = GoogleFonts.sourceSans3TextTheme(base.textTheme);

    final text = sans.copyWith(
      displayLarge: serif.displayLarge?.copyWith(
        color: colors.ink,
        fontWeight: FontWeight.w700,
        height: 1.15,
      ),
      displayMedium: serif.displayMedium?.copyWith(
        color: colors.ink,
        fontWeight: FontWeight.w700,
        height: 1.15,
      ),
      displaySmall: serif.displaySmall?.copyWith(
        color: colors.ink,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      headlineLarge: serif.headlineLarge?.copyWith(
        color: colors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 28,
        height: 1.2,
      ),
      headlineMedium: serif.headlineMedium?.copyWith(
        color: colors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 24,
        height: 1.25,
      ),
      headlineSmall: serif.headlineSmall?.copyWith(
        color: colors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 20,
        height: 1.25,
      ),
      titleLarge: sans.titleLarge?.copyWith(
        color: colors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
      titleMedium: sans.titleMedium?.copyWith(
        color: colors.ink,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      titleSmall: sans.titleSmall?.copyWith(
        color: colors.ink,
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 0.4,
      ),
      bodyLarge: sans.bodyLarge?.copyWith(
        color: colors.ink,
        fontSize: 17,
        height: 1.45,
      ),
      bodyMedium: sans.bodyMedium?.copyWith(
        color: colors.ink,
        fontSize: 15,
        height: 1.4,
      ),
      bodySmall: sans.bodySmall?.copyWith(
        color: colors.muted,
        fontSize: 13,
        height: 1.35,
      ),
      labelLarge: sans.labelLarge?.copyWith(
        color: colors.ink,
        fontWeight: FontWeight.w700,
        fontSize: 13,
        letterSpacing: 0.8,
      ),
      labelMedium: sans.labelMedium?.copyWith(
        color: colors.muted,
        fontWeight: FontWeight.w600,
        fontSize: 12,
        letterSpacing: 1.0,
      ),
      labelSmall: sans.labelSmall?.copyWith(
        color: colors.muted,
        fontWeight: FontWeight.w600,
        fontSize: 11,
        letterSpacing: 1.1,
      ),
    );

    final scheme = ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      secondary: colors.secondary,
      onSecondary: colors.onSecondary,
      tertiary: colors.tertiary,
      onTertiary: colors.ink,
      error: colors.danger,
      onError: colors.onPrimary,
      surface: colors.surface,
      onSurface: colors.ink,
      surfaceContainerHighest: colors.surfaceContainerHigh,
      outline: colors.outline,
      outlineVariant: colors.line,
    );

    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.background,
      textTheme: text,
      extensions: [colors],
      pageTransitionsTheme: AppMotion.pageTransitions,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colors.surface,
        foregroundColor: colors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        systemOverlayStyle: systemUi,
      ),
      dividerTheme: DividerThemeData(
        color: colors.line,
        thickness: 1,
        space: 1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colors.chipPeach,
        selectedColor: colors.primary,
        labelStyle: text.labelLarge!,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: const StadiumBorder(),
        side: BorderSide.none,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.ink,
          foregroundColor: colors.onPrimary,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          textStyle: text.labelLarge?.copyWith(letterSpacing: 1.2),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.ink,
          minimumSize: const Size.fromHeight(52),
          side: BorderSide(color: colors.ink, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          textStyle: text.labelLarge?.copyWith(letterSpacing: 1.2),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceContainerLow,
        hintStyle: text.bodyMedium?.copyWith(color: colors.muted),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: colors.primary, width: 1.4),
        ),
      ),
    );
  }
}
