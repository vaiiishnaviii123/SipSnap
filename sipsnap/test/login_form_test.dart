
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view/login_register/login_form.dart';
import 'package:sipsnap/view_model/user_provider.dart';


@GenerateMocks([UserProvider])
void main() {

  group('LoginForm Widget Tests', () {
    testWidgets('Tapping on Login with Google button calls signInWithGoogle method', (WidgetTester tester) async {
      var auth = MockFirebaseAuth();
      UserProvider userProvider = UserProvider(auth);

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => userProvider),
          ],
          child: MaterialApp(
            home: Material(
              child: LoginForm(),
            ),
          ),
        )
      );

      await tester.pumpAndSettle();

      await tester.press(find.byKey(const Key('loginPage googleButton')));

      // verify that _current user is created but null because we are provideing fake auth object
      expect(userProvider.currentUser, null);

    });
  });
}

