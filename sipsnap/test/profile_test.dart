import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view/profile_views/profile_page.dart';
import 'package:sipsnap/view_model/user_provider.dart';

void main() {
  testWidgets('ProfilePage displays user profile information', (WidgetTester tester) async {
    // Create a mock instance of UserProvider
    var auth = MockFirebaseAuth();
    var userProvider = UserProvider(auth);

    // Build the ProfilePage widget within a test environment
    await tester.pumpWidget(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => userProvider),
      ],
      child: const MaterialApp(
        home: Material(
          child: ProfilePage(),
        ),
        )
      ),
    );

    // pump and settle
    await tester.pumpAndSettle();

    print('widget successfuly built');
    // verify 3 widgets image and 2 text widgets
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(Text), findsAtLeast(2));
  });
}
