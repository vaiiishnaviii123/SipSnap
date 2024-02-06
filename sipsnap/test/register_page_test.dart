import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/register_page_event.dart';
import 'package:sipsnap/view/login_register/register_page.dart';
import 'package:sipsnap/view_model/register_page_provider.dart'; // Import your provider

void main() {
  testWidgets('Empty Form Submission Test', (WidgetTester tester) async {
    // Create a mock RegisterPageProvider
    final registerPageProvider = RegisterPageProvider();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value( // Provide the provider to the widget tree
          value: registerPageProvider,
          child: RegisterPage(),
        ),
      ),
    );

    // Tap on the register button
    await tester.tap(find.byKey(const Key('registerpage register button')));
    await tester.pump();

    // expect to be on same page
    expect(find.byType(RegisterPage), findsOneWidget);
  });

  testWidgets('Invalid Email Test', (WidgetTester tester) async {
    final registerPageProvider = RegisterPageProvider();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: registerPageProvider,
          child: RegisterPage(),
        ),
      ),
    );

    // Enter an invalid email format
    await tester.enterText(find.byKey(const Key('register email field')), 'testemail.com');

    // Tap on the register button
    await tester.tap(find.byKey(const Key('registerpage register button')));
    await tester.pump();

    // expect to be on same page
    expect(find.byType(RegisterPage), findsOneWidget);
  });

  // test for checking password and confirm password
  testWidgets('Password and Confirm Password Test', (WidgetTester tester) async {
    final registerPageProvider = RegisterPageProvider();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: registerPageProvider,
          child: RegisterPage(),
        ),
      ),
    );

    // Enter a password
    await tester.enterText(find.byKey(const Key('register email field')), 'asd@asd.asd');
    await tester.enterText(find.byKey(const Key('register password field')), 'password');
    await tester.enterText(find.byKey(const Key('register confirm password field')), 'passrd');

    // Tap on the register button
    await tester.tap(find.byKey(const Key('registerpage register button')));
    await tester.pump();

    // expect to be on same page
    expect(find.byType(RegisterPage), findsOneWidget);
  });

  // test for checking duplicate email
  testWidgets('Duplicate Email Test', (WidgetTester tester) async {
    final registerPageProvider = RegisterPageProvider();

    // enter a register page event
    final event = RegisterPageEvent(
      id: '1',
      email: 'asd@asd.asd',
      password: 'password',
      confirmPassword: 'password',
    );

    registerPageProvider.addRegisterPageEvent(event);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: registerPageProvider,
          child: RegisterPage(),
        ),
      ),
    );

    // Enter a password
    await tester.enterText(find.byKey(const Key('register email field')), 'asd@asd.asd');
    await tester.enterText(find.byKey(const Key('register password field')), 'password');
    await tester.enterText(find.byKey(const Key('register confirm password field')), 'password');

    // expect to be on same page
    expect(find.byType(RegisterPage), findsOneWidget);

    bool result = registerPageProvider.checkForDuplicateEmail('asd@asd.asd');

    expect(result, true);
  });

  // test for successful registration
  testWidgets('Successful Registration Test', (WidgetTester tester) async {
    final registerPageProvider = RegisterPageProvider();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => registerPageProvider,
          child: RegisterPage(),
        ),
      ),
    );

    final event = RegisterPageEvent(
      id: '1',
      email: 'asd@asd.asd',
      password: 'password',
      confirmPassword: 'password',
    );

    registerPageProvider.addRegisterPageEvent(event);

    // expect a new entry in the registerPageProvider
    expect(registerPageProvider.registerPageEvent.length, 1);
  });

}
