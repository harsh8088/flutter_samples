// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_samples/test_widget/calculator.dart';
import 'package:flutter_samples/test_widget/greeting_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculator tests', () {
    test('Addition should work correctly', () {
      final calculator = Calculator();
      expect(calculator.add(2, 3), equals(5));
      expect(calculator.add(double.nan, 3), isNaN);
    });

    test('Subtraction should work correctly', () {
      final calculator = Calculator();
      expect(calculator.subtract(5, 2), equals(3));
    });
    test('Multiplication should work correctly', () {
      final calculator = Calculator();
      expect(calculator.multiply(5, 2), equals(10));
    });
    test('Dividing should work correctly', () {
      final calculator = Calculator();
      expect(calculator.divide(5, 2), equals(2.5));
    });
    test('Dividing by zero should throw an ArgumentError', () {
      final calculator = Calculator();
      expect(() => calculator.divide(5, 0), throwsA(isA<ArgumentError>()));
    });
  });

  testWidgets('GreetingWidget displays correct text',
      (WidgetTester tester) async {
    // Create the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: GreetingWidget(name: 'Amit Kumar'),
      ),
    );

    // Find the text widget and verify it's content
    final textFinder = find.text('Welcome, Amit Kumar!');
    expect(textFinder, findsOneWidget);
  });
}
