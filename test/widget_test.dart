import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:recipe_studio/main.dart';

void main() {
  testWidgets('the app starts', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: FlutterGoApp()));
    await tester.pump();
    expect(find.byType(Scaffold), findsWidgets);
  });
}
