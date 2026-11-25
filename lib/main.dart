import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'motion/app_motion.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppMotion.personality = MotionPersonality.calm;
  AppMotion.style = MotionStyle.soft;
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(AppTheme.systemUi);
  runApp(const ProviderScope(child: FlutterGoApp()));
}

class FlutterGoApp extends ConsumerWidget {
  const FlutterGoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppTheme.systemUi,
      child: MaterialApp.router(
        title: 'Recipe Studio',
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: AppTheme.defaultMode,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        builder: (context, child) => AppTheme.withSystemUi(context, child!),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
          Locale('ur'),
          Locale('fa'),
          Locale('he'),
          Locale('fr'),
          Locale('es'),
          Locale('de'),
          Locale('tr'),
          Locale('ru'),
          Locale('hi'),
          Locale('id'),
          Locale('pt'),
          Locale('it'),
          Locale('zh'),
          Locale('ja'),
          Locale('ko'),
        ],
      ),
    );
  }
}
