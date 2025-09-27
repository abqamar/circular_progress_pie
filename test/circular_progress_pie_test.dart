import 'package:circular_progress_pie/src/circular_progress_pie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CircularProgressPie', () {
    testWidgets('renders with basic properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        const CircularProgressPie(
          value: 0.5,
          size: 100,
          progressColor: Colors.blue,
        ),
      );

      expect(find.byType(CircularProgressPie), findsOneWidget);
    });

    testWidgets('validates value range', (WidgetTester tester) async {
      // Test that value cannot be less than 0.0
      expect(
            () => CircularProgressPie(value: -0.1, size: 100),
        throwsAssertionError,
      );

      // Test that value cannot be greater than 1.0
      expect(
            () => CircularProgressPie(value: 1.1, size: 100),
        throwsAssertionError,
      );
    });

    testWidgets('circular constructor works', (WidgetTester tester) async {
      await tester.pumpWidget(
        CircularProgressPie.circular(
          value: 0.7,
          size: 50,
          progressColor: Colors.red,
        ),
      );

      expect(find.byType(CircularProgressPie), findsOneWidget);
    });

    testWidgets('percentage constructor works', (WidgetTester tester) async {
      await tester.pumpWidget(
        CircularProgressPie.percentage(value: 0.8),
      );

      expect(find.byType(CircularProgressPie), findsOneWidget);
      expect(find.text('80%'), findsOneWidget);
    });

    testWidgets('gradient constructor works', (WidgetTester tester) async {
      await tester.pumpWidget(
        CircularProgressPie.gradient(
          value: 0.6,
          gradient: const LinearGradient(colors: [Colors.red, Colors.blue]),
        ),
      );

      expect(find.byType(CircularProgressPie), findsOneWidget);
    });

    testWidgets('respects size parameter', (WidgetTester tester) async {
      const testSize = 150.0;

      await tester.pumpWidget(
        const CircularProgressPie(
          value: 0.5,
          size: testSize,
        ),
      );

      final progressIndicator = tester.widget<CircularProgressPie>(
        find.byType(CircularProgressPie),
      );

      expect(progressIndicator.size, testSize);
    });

    testWidgets('handles edge cases', (WidgetTester tester) async {
      // Test value 0.0
      await tester.pumpWidget(
        const CircularProgressPie(value: 0.0, size: 100),
      );
      expect(find.byType(CircularProgressPie), findsOneWidget);

      // Test value 1.0
      await tester.pumpWidget(
        const CircularProgressPie(value: 1.0, size: 100),
      );
      expect(find.byType(CircularProgressPie), findsOneWidget);
    });

    testWidgets('animation types work', (WidgetTester tester) async {
      for (final type in PieAnimationType.values) {
        await tester.pumpWidget(
          CircularProgressPie(
            value: 0.5,
            size: 100,
            animationType: type,
          ),
        );
        expect(find.byType(CircularProgressPie), findsOneWidget);
      }
    });

    testWidgets('child widget is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(
        const CircularProgressPie(
          value: 0.5,
          size: 100,
          child: Text('Test'),
        ),
      );

      expect(find.byType(CircularProgressPie), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('reverse property works', (WidgetTester tester) async {
      await tester.pumpWidget(
        const CircularProgressPie(
          value: 0.5,
          size: 100,
          reverse: true,
        ),
      );

      expect(find.byType(CircularProgressPie), findsOneWidget);
    });

    testWidgets('isFilled property works', (WidgetTester tester) async {
      await tester.pumpWidget(
        const CircularProgressPie(
          value: 0.5,
          size: 100,
          isFilled: false,
          strokeWidth: 5,
        ),
      );

      expect(find.byType(CircularProgressPie), findsOneWidget);
    });
  });

  group('PieAnimationType', () {
    test('has correct values', () {
      expect(PieAnimationType.values.length, 4);
      expect(PieAnimationType.sweep, isNotNull);
      expect(PieAnimationType.fill, isNotNull);
      expect(PieAnimationType.bounce, isNotNull);
      expect(PieAnimationType.elastic, isNotNull);
    });
  });
}