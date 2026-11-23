import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_app/main.dart';

void main() {
  testWidgets('SplashScreen navigates to SignInScreen and SignUpScreen shows student info',
      (WidgetTester tester) async {
    // Set test screen size for desktop layout
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;

    // Build app
    await tester.pumpWidget(const MyApp());

    // Verify SplashScreen initial content
    expect(find.text('My Flutter App'), findsOneWidget);
    expect(find.text('Riphah International University'), findsOneWidget);

    // Fast-forward 3 seconds to complete splash timer
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Verify transition to SignInScreen
    expect(find.text('Welcome Back'), findsOneWidget);

    // Navigate to SignUpScreen
    await tester.tap(find.text('Sign Up'), warnIfMissed: false);
    await tester.pumpAndSettle();

    // Verify SignUpScreen student info at bottom
    expect(find.text('Student Registration Info'), findsOneWidget);
    expect(find.text('Name: Muhammad Hammad Qayyum'), findsOneWidget);
    expect(find.text('Student ID: 27931'), findsOneWidget);
    expect(find.text('Email: 27931@students.riphah.edu.pk'), findsOneWidget);

    // Reset surface size after test
    addTearDown(tester.view.resetPhysicalSize);
  });
}
