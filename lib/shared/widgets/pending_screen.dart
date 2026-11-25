import 'package:flutter/material.dart';

import '../../motion/app_reveal.dart';
import '../../theme/app_chrome.dart';
import '../../theme/app_colors.dart';

/// Temporary route target until a screen file is swapped in.
class PendingScreen extends StatelessWidget {
  const PendingScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return ChromeScope(
      top: colors.background,
      bottom: colors.background,
      child: Scaffold(
        backgroundColor: colors.background,
        body: Center(
          child: AppReveal(
            child: Text(
              'Coming up next',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
      ),
    );
  }
}
