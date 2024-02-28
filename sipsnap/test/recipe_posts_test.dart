import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view/recipe_views/recipe_posts_page.dart';
import 'package:sipsnap/view_model/recipe_database_service.dart';
import 'package:sipsnap/view_model/recipe_posts_provider.dart';

void main() {
  group('recipe_posts_test', () {
    testWidgets('Recipe Posts Widget renders correctly',
        (WidgetTester tester) async {
          final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();

          await tester.pumpWidget(
              MultiProvider(
                providers: [
                  Provider(create: (context)=>RecipeDatabase(fakeFirebaseFirestore)),
                  ChangeNotifierProvider(create: (context)=>RecipePostsProvider())
                ],
                child: MaterialApp(
                  home: Material(
                    child: RecipePostsPage(),
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
