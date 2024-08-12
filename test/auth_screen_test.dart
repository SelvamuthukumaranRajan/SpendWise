import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:spend_wise/views/auth_screen.dart';
import 'package:spend_wise/widgets/auth_signIn_sheet.dart';
import 'package:spend_wise/widgets/auth_signup_sheet.dart';

import 'auth_screen_test.mocks.dart';

@GenerateMocks([NavigatorObserver])
void main() {
  late MockNavigatorObserver mockObserver;

  setUp(() {
    mockObserver = MockNavigatorObserver();
  });

  Future<void> buildAuthScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const AuthScreen(),
        navigatorObservers: [mockObserver],
      ),
    );
  }

  testWidgets(
      'Signup button shows AuthSignupSheet and navigates to home on success',
      (WidgetTester tester) async {
    await buildAuthScreen(tester);

    // Tap the Signup button
    final signupButton = find.text('Signup');
    expect(signupButton, findsOneWidget);
    await tester.tap(signupButton);
    await tester.pumpAndSettle();

    // Verify that AuthSignupSheet is shown
    expect(find.byType(AuthSignupSheet), findsOneWidget);

    // Simulate the bottom sheet returning true
    const isSuccess = true;
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.pop(isSuccess);
    await tester.pumpAndSettle();

    // Verify that Navigator.pushNamed is called
    verify(mockObserver.didPush(any, any)).called(1);
  });

  testWidgets(
      'Login button shows AuthSignInSheet and navigates to home on success',
      (WidgetTester tester) async {
    await buildAuthScreen(tester);

    // Tap the Login button
    final loginButton = find.text('Already have an account? Log in');
    expect(loginButton, findsOneWidget);
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Verify that AuthSignInSheet is shown
    expect(find.byType(AuthSignInSheet), findsOneWidget);

    // Simulate the bottom sheet returning true
    const isSuccess = true;
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.pop(isSuccess);
    await tester.pumpAndSettle();

    // Verify that Navigator.pushNamed is called
    verify(mockObserver.didPush(any, any)).called(1);
  });
}
