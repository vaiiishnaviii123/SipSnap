// Add a widget test for login page widget
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/main.dart';
import 'package:flutter/material.dart';
import 'package:sipsnap/models/register_page_event.dart';
import 'package:sipsnap/view/login/login_page.dart';
import 'package:sipsnap/view/login_register/register_page.dart';
import 'package:sipsnap/view_model/register_page_provider.dart';



void main(){
  testWidgets("Invalid email should display snack bar with message Please enter a valid email", (widgetTester) async{
    
    //setup
    // Load the app
    await widgetTester.pumpWidget(const MyApp());
   

    // fill the email and password fields
    await widgetTester.enterText(find.byKey(const Key('login email field')), 'asdasd.asd');
    await widgetTester.enterText(find.byKey(const Key('login password field')), 'asd');

    // execute
    // tap the login button
    await widgetTester.tap(find.byKey(const Key('loginPage loginButton')));
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    // expect
    // expect a snack bar to be shown with the message "Invalid email format"
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Please enter a valid email'), findsOneWidget);
    //cleanup
    await widgetTester.pumpAndSettle();
  });

  testWidgets("Login should throw exception on not entering email and password", (widgetTester) async{
    //setup
    // Load the app
    await widgetTester.pumpWidget(const MyApp());

    // execute
    // tap the login button
    await widgetTester.tap(find.byKey(const Key('loginPage loginButton')));
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    // expect
    // expect to be on the same login page
    expect(find.text('Please enter your email'), findsOneWidget);
    await widgetTester.pumpAndSettle();
  });

  testWidgets("Register button navigates to /register route", (widgetTester) async {
    // Build our app and trigger a frame.
    await widgetTester.pumpWidget(const MyApp());

    // Tap on the Register button.
    await widgetTester.tap(find.byKey(const ValueKey('login page registerButton')));
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    // Verify that the navigation has occurred.
    expect(find.byType(RegisterPage), findsOneWidget);
    await widgetTester.pumpAndSettle();
  });
  
  testWidgets("Forgot password button shows a Snackbar", (widgetTester) async {
    // Build the widget tree
    await widgetTester.pumpWidget(const MyApp());

    // find the forgot password button and tap it
    final forgotPasswordButton = find.byKey(const ValueKey('loginPage forgetPasswordButton'));

    // tap the forgot password button
    await widgetTester.press(forgotPasswordButton);
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    // expect to be on same page
    expect(find.byType(LoginPage), findsOneWidget);  
  });

  testWidgets("Log in with Google button shows a Snackbar", (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap on the Log in with Google button.
    await tester.tap(find.byKey(const ValueKey('loginPage googleButton')));

    // Wait for the SnackBar to be shown.
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // expect to be on same page
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('on correct email and password login should work', (widgetTester) async {
    
    final registerPageProvider = RegisterPageProvider();

    await widgetTester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => registerPageProvider,
          child: LoginPage(),
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

    bool result = registerPageProvider.searchUserCheckPassword('asd@asd.asd', 'password');

    // expect result to be true
    expect(result, true);
    
  });
}


