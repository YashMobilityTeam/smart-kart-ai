import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('basic MaterialApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('SmartKartAI')),
        ),
      ),
    );

    expect(find.text('SmartKartAI'), findsOneWidget);
  });
}
