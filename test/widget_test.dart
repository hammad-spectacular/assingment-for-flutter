import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_profile_app/main.dart';

void main() {
  testWidgets('SplashScreen displays title and navigates to HomeScreen',
      (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(const MyApp());

    // Verify SplashScreen initial content
    expect(find.text('My Flutter App'), findsOneWidget);
    expect(find.text('Riphah International University'), findsOneWidget);

    // Fast-forward 3 seconds to complete splash timer
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Verify transition to HomeScreen
    expect(find.text('Home Screen'), findsOneWidget);
    expect(find.text('Welcome, Muhammad Hammad Qayyum!'), findsOneWidget);
  });
}
