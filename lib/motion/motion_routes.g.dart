// Generated route-transition configuration. Update the route map when the
// application's navigation motion plan changes.
// dart format off
// ignore_for_file: lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'motion_recipes.dart';

const Map<String, MotionTransitionKind> motionRoutes = <String, MotionTransitionKind>{
};

/// The planned transition for a route (platform when the plan has none).
MotionTransitionKind motionTransition(String from, String to) =>
    motionRoutes['$from>$to'] ?? MotionTransitionKind.platform;

/// Navigator.push(context, motionRoute('today', 'detail', (_) => DetailScreen()))
Route<T> motionRoute<T>(String from, String to, WidgetBuilder builder, {RouteSettings? settings}) =>
    MotionTransitions.route<T>(motionTransition(from, to), builder, settings: settings);

/// GoRoute(pageBuilder: (c, s) => motionPage(s, from: 'today', to: 'detail', child: DetailScreen()))
Page<void> motionPage(GoRouterState state, {required String from, required String to, required Widget child}) {
  final kind = motionTransition(from, to);
  final overlay = MotionTransitions.isOverlay(kind);
  final origin = MotionOrigin.take();
  return CustomTransitionPage<void>(
    key: state.pageKey,
    opaque: !overlay,
    barrierDismissible: overlay,
    barrierColor: overlay ? Colors.black38 : null,
    transitionDuration: MotionTransitions.duration(kind),
    reverseTransitionDuration: MotionTransitions.duration(kind) * 0.75,
    child: child,
    transitionsBuilder: (context, a, s, child) => MotionTransitions.build(context, kind, a, s, child, origin: origin),
  );
}
