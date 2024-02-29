import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view/common_widgets/custom_drawer.dart';
import 'package:sipsnap/view_model/user_provider.dart';


void main() {
  testWidgets('CustomDrawer Widget Test', (WidgetTester tester) async {
    // Mock dependencies
    var auth = MockFirebaseAuth();
    var userProvider = UserProvider(auth);

    // Build CustomDrawer widget within a test environment
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => userProvider),
        ],
        child: const MaterialApp(
          home: Material(
            child: CustomDrawer(),
          ),
        ),
      ),
    );

    // pump and settle
    await tester.pumpAndSettle();

    // Verify that the DrawerHeader widget is displayed
    expect(find.byType(DrawerHeader), findsOneWidget);

    // Verify that the ListTile widgets are displayed
    expect(find.byType(ListTile), findsNWidgets(2));

  });
}
