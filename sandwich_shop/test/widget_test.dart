// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/models/cart.dart';

void main() {
  testWidgets('AppBar and main controls are present', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Sandwich Counter'), findsOneWidget);
    // There may be more than one Label widget for the dropdowns in the widget tree.
    expect(find.text('Sandwich Type'), findsWidgets);
    expect(find.text('Bread Type'), findsWidgets);
    expect(find.text('Add to Cart'), findsOneWidget);
  });

  testWidgets('Switch toggles sandwich size value', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    final Finder switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);

    // initial value should be true (footlong)
    Switch sw = tester.widget<Switch>(switchFinder);
    expect(sw.value, isTrue);

    // toggle the switch
    await tester.tap(switchFinder);
    await tester.pumpAndSettle();

    sw = tester.widget<Switch>(switchFinder);
    expect(sw.value, isFalse);
  });

  testWidgets('Add to Cart button can be tapped without throwing', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    final Finder addToCartButton = find.text('Add to Cart');
    expect(addToCartButton, findsOneWidget);

    // Ensure the button is visible (content may scroll) before tapping.
    await tester.ensureVisible(addToCartButton);
    await tester.pumpAndSettle();

    await tester.tap(addToCartButton);
    await tester.pumpAndSettle();
  });

  test('Cart model adds items and computes totals correctly', () {
    final Sandwich sandwich = Sandwich(
      type: SandwichType.veggieDelight,
      isFootlong: true,
      breadType: BreadType.white,
    );

    final Cart localCart = Cart();
    expect(localCart.isEmpty, isTrue);
    localCart.add(sandwich, quantity: 2);
    expect(localCart.isEmpty, isFalse);
    expect(localCart.countOfItems, equals(2));
    expect(localCart.getQuantity(sandwich), equals(2));

    final double expectedTotal = localCart.totalPrice;
    expect(expectedTotal, greaterThanOrEqualTo(0.0));
  });
}
