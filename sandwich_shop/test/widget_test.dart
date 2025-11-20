// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sandwich_shop/main.dart';
void main() {
  testWidgets('Switch toggles sandwich size between six-inch and footlong',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // Verify initial order display shows "footlong" (and mentions "sandwich")
    final Finder footlongOrderFinder = find.byWidgetPredicate((widget) {
      return widget is Text &&
          widget.data != null &&
          widget.data!.contains('footlong') &&
          widget.data!.contains('sandwich');
    });
    expect(footlongOrderFinder, findsOneWidget);

    // Find the Switch and toggle it
    final Finder switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);
    await tester.tap(switchFinder);
    await tester.pumpAndSettle();

    // After toggling, the order display should show "six-inch" (and mention "sandwich")
    final Finder sixInchOrderFinder = find.byWidgetPredicate((widget) {
      return widget is Text &&
          widget.data != null &&
          widget.data!.contains('six-inch') &&
          widget.data!.contains('sandwich');
    });
    expect(sixInchOrderFinder, findsOneWidget);
  });
}
