import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lastest_broo/Login_page.dart';

void main() {
  testWidgets('LoginPage UI test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(LoginPage());

    // Verify that Email and Password text fields are present.
    expect(find.byType(TextField), findsNWidgets(2));

    // Enter text into the Email field.
    await tester.enterText(
        find.widgetWithText(TextField, 'Email'), 'test@example.com');

    // Enter text into the Password field.
    await tester.enterText(
        find.widgetWithText(TextField, 'Password'), 'password123');

    // Tap the login button.
    await tester.tap(find.byType(ElevatedButton));

    // Rebuild the widget after the state has changed.
    await tester.pump();
  });
}
