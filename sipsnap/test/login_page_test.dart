// Add a widget test for login page widget

import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view/login_register/login_form.dart';
import 'package:sipsnap/view/login_register/login_page.dart';
import 'package:sipsnap/view_model/user_provider.dart';

void main(){

  testWidgets('LoginPage should contain welcome text, logo, and login form', (WidgetTester tester) async {

    var auth = MockFirebaseAuth();
    UserProvider userProvider = UserProvider(auth);

    await tester.pumpWidget(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => userProvider),
      ],
        child: const MaterialApp(
          home: Material(
            child: LoginPage(),
          ),
        ),
      )
    );

    // pumpWidget 
    await tester.pumpAndSettle();

    // Verify the presence of welcome text
    expect(find.text('Welcome to Sip Snap'), findsOneWidget);

    // Verify the presence of the logo image
    expect(find.byType(Image), findsOneWidget);

    // Verify the presence of the login form
    expect(find.byType(LoginForm), findsOneWidget);
  });
}


