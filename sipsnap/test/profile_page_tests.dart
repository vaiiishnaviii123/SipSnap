import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/user_model.dart';
import 'package:sipsnap/view/profile_views/profile_page.dart';
import 'package:sipsnap/view_model/user_provider.dart';

import 'profile_page_tests.mocks.dart';

@GenerateMocks([UserProvider])
void main() {
  group('profile page tests', () {
    testWidgets('Profile Page Widget renders correctly',
            (WidgetTester tester) async {
          UserProvider provider = new MockUserProvider();
          UserModal userModal = UserModal(
            uuid: 'dgfjdjfj3456342354',
            email: 'admin@admin.com',
            name: 'Admin',
            photoUrl: '',
          );
          when(
              provider.currentUser
          ).thenAnswer((_) => userModal);

          await tester.pumpWidget(
              MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (context)=>provider)
                ],
                child: MaterialApp(
                  home: Material(
                    child: ProfilePage(),
                  ),
                ),
              )
          );
          await tester.pump();
          expect(find.textContaining('Name'), findsOneWidget);
          expect(find.textContaining('Email'), findsOneWidget);
          expect(find.textContaining('Profile Page'), findsOneWidget);
          expect(find.textContaining('admin@admin.com'), findsOneWidget);
          expect(find.textContaining('Admin'), findsOneWidget);
    });
  });
}
