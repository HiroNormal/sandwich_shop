import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sandwich_shop/main.dart';

void main() {
  testWidgets('sandwich quantity updates with add and remove buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.textContaining('Footlong'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
    await tester.pump();

    expect(find.textContaining('1 Footlong'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Remove'));
    await tester.pump();

    expect(find.textContaining('0 Footlong'), findsOneWidget);
  });
}
