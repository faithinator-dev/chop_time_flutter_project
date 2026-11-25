import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../assets/app_assets.dart';
import '../../motion/app_kinetic_text.dart';
import '../../motion/app_motion.dart';
import '../../motion/app_reveal.dart';
import '../../theme/app_chrome.dart';
import '../../theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(AppMotion.ms(1600), () {
      if (!mounted) return;
      context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return ChromeScope(
      top: colors.primary,
      bottom: colors.primary,
      child: Scaffold(
        backgroundColor: colors.primary,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppReveal(
                  style: RevealStyle.pop,
                  child: Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: colors.onPrimary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.all(18),
                    child: SvgPicture.asset(
                      AppAssets.logo,
                      colorFilter: ColorFilter.mode(
                        colors.onPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                AppKineticText(
                  'Recipe Studio',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                  kinetic: KineticStyle.rise,
                ),
                const SizedBox(height: 10),
                AppReveal(
                  index: 1,
                  child: Text(
                    'Cook something wonderful tonight',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.onPrimary.withValues(alpha: 0.85),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
