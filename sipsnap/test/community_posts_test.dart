import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view/community_views/community_posts_page.dart';
import 'package:sipsnap/view_model/community_database_service.dart';
import 'package:sipsnap/view_model/community_posts_provider.dart';

void main() {
  group('community_posts_test', () {
    testWidgets('Community Posts Widget renders correctly',
        (WidgetTester tester) async {
          final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();
          await tester.pumpWidget(
              MultiProvider(
                providers: [
                  Provider(create: (context)=>CommunityDatabase(fakeFirebaseFirestore)),
                  ChangeNotifierProvider(create: (context)=>CommunityPostsProvider())
                ],
                child: MaterialApp(
                  home: Material(
                    child: CommunityPostsPage(),
                  ),
                ),
              )
          );
          final listFinder = find.byKey(ValueKey('list'));
          expect(listFinder, findsOneWidget);
          await tester.pump();
          expect(find.byKey(ValueKey("list")), findsOneWidget);
    });
  });
}
