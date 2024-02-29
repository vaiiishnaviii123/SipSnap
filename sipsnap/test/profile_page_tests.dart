import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/user_model.dart';
import 'package:sipsnap/view/profile_views/profile_page.dart';
import 'package:sipsnap/view_model/user_provider.dart';

// Generate a mock class for UserProvider
class MockUserProvider extends Mock implements UserProvider {}

void main() {
  testWidgets('ProfilePage displays user profile information', (WidgetTester tester) async {
    // Create a mock instance of UserProvider
    var userProvider = MockUserProvider();

    // Provide mock data for currentUser
    when(userProvider.currentUser).thenReturn(UserModal(
      name: 'John Doe',
      email: 'john@example.com',
      photoUrl: 'https://example.com/avatar.jpg',
    ));

    // Build the ProfilePage widget within a test environment
    await tester.pumpWidget(
      Provider<UserProvider>.value(
        value: userProvider,
        child: const MaterialApp(
          home: ProfilePage(),
        ),
      ),
    );

    // Verify the presence of user profile information
    expect(find.text('John Doe'), findsOneWidget); // Verify name
    expect(find.text('john@example.com'), findsOneWidget); // Verify email
    expect(find.byType(Image), findsOneWidget); // Verify presence of Image widget
  });
}
