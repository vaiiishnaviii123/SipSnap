import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view/login_register/login_form.dart';
import 'mocks/mock_user_provider.dart';


void main() {

  setUpAll(() async{
    await Firebase.initializeApp();
  });

  group('LoginForm Widget Tests', () {
    testWidgets('Tapping on Login with Google button calls signInWithGoogle method', (WidgetTester tester) async {

      // Create a mock UserProvider
      final mockUserProvider = MockUserProvider();

      // Build the widget
      await tester.pumpWidget(
        MultiProvider(
         providers: [
          ChangeNotifierProvider(create: (context) => mockUserProvider),
         ],
          child: MaterialApp(
            home: Material(
              child: LoginForm(),
            ),
          )
        )
      );

      // find the login with google button
      final loginWithGoogleButton = find.byKey(const ValueKey('loginPage googleButton'));

      // Tap on the Login with Google button
      await tester.tap(loginWithGoogleButton);
      await tester.pumpAndSettle();


      // Verify that signInWithGoogle method is called
      verify(mockUserProvider.signInWithGoogle()).called(1);
    });
  });
}

