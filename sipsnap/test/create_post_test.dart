import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/community_posts_model.dart';
import 'package:sipsnap/models/recipe_posts_model.dart';
import 'package:sipsnap/view/community_views/community_posts_card.dart';
import 'package:sipsnap/view/create_post/Create_post_page.dart';
import 'package:sipsnap/view/recipe_views/recipe_posts_card.dart';
import 'package:sipsnap/view_model/comment_provider.dart';
import 'package:sipsnap/view_model/community_database_service.dart';
import 'package:sipsnap/view_model/community_posts_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sipsnap/view_model/recipe_database_service.dart';
import 'package:sipsnap/view_model/recipe_posts_provider.dart';
import 'package:sipsnap/view_model/user_provider.dart';
import 'create_post_test.mocks.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';


@GenerateMocks([CommunityPostsProvider])
@GenerateMocks([RecipePostsProvider])
void main() {
  testWidgets('Testing create community posts', (tester) async {
    CommunityPostsProvider mockCommunityPostsProvider = MockCommunityPostsProvider();
    final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();

    CommunityPost communityPost = CommunityPost(
      postTitle: 'Seattle Events',
      username: 'MockUser1',
      description: 'Mock Description 1',
      imageRef: '', // Commented out for now
    );

    List<CommunityPost> communityEvents = [
      CommunityPost(
        postTitle: 'Seattle Events',
        username: 'MockUser1',
        description: 'Mock Description 1',
        imageRef: '', // Commented out for now
      ),
    ];
    when(
        mockCommunityPostsProvider.communityPosts
    ).thenAnswer((_) => communityEvents);

    await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider(create: (context)=>CommunityDatabase(fakeFirebaseFirestore)),
            Provider(create: (context)=>RecipeDatabase(fakeFirebaseFirestore)),
            ChangeNotifierProvider(create: (context) => UserProvider()),
            ChangeNotifierProvider(create: (context)=>mockCommunityPostsProvider)
          ],
          child: MaterialApp(
            home: Material(
              child: CreatePostPage(),
            ),
          ),
        )
    );
    final buttonFinder = find.byKey(ValueKey('SavePost'));
    final descriptionFinder = find.byKey(ValueKey("Description"));
    final titleFinder = find.byKey(ValueKey("Title"));
    final postTypeFinder = find.byKey(ValueKey("Type"));

    expect(buttonFinder, findsOneWidget);
    expect(descriptionFinder, findsOneWidget);
    expect(titleFinder, findsOneWidget);
    expect(postTypeFinder, findsOneWidget);

    await tester.tap(postTypeFinder);
    await tester.pump();
    await tester.pump(Duration(seconds: 1));
    await tester.tap(find.text('Community Post').last);

    await tester.enterText(titleFinder, "Seattle Boba Event");
    await tester.enterText(descriptionFinder, "Events in 2024.");
    await tester.dragUntilVisible(
      buttonFinder, // what you want to find
      find.byType(SingleChildScrollView), // widget you want to scroll
      const Offset(0, 50), // delta to move
    );
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    final snapshot = await fakeFirebaseFirestore.collection('community').get();
    expect(snapshot.docs.length, 1);
    expect(snapshot.docs.first.get('description'), isNotNull);
    expect(snapshot.docs.first.get('postTitle'), isNotNull);


    final snackBarFinder = find.byKey(ValueKey("SnackBar")).last;
    expect(snackBarFinder, findsOneWidget);
    expect(find.textContaining('successfully'), findsOneWidget);

    await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CommentProvider(fakeFirebaseFirestore)),
            ChangeNotifierProvider(create: (context)=>mockCommunityPostsProvider)
          ],
          child: MaterialApp(
            home: Material(
              child: CommunityPostCard(post: communityPost),
            ),
          ),
        )
    );
    await tester.pump();
    expect(find.byKey(ValueKey('card')), findsOneWidget);
    expect(find.textContaining('Seattle'), findsOneWidget);
    expect(find.textContaining('Description'), findsOneWidget);
  });

  testWidgets('Testing create recipe posts', (tester) async {
    RecipePostsProvider mockRecipePostsProvider = MockRecipePostsProvider();
    final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();

    RecipePost recipePost = RecipePost(
        recipeTitle: "Lavender Boba",
        userName: "Admin",
        description: "First Recipe",
        imageRef: 'assets/spaceneedle.jpg'
    );

    List<RecipePost> recipeEvents = [
      RecipePost(
          recipeTitle: "Lavender Boba",
          userName: "Admin",
          description: "First Recipe",
          imageRef: 'assets/spaceneedle.jpg')
    ];

    when(
        mockRecipePostsProvider.recipePosts
    ).thenAnswer((_) => recipeEvents);


    await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider(create: (context)=>CommunityDatabase(fakeFirebaseFirestore)),
            Provider(create: (context)=>RecipeDatabase(fakeFirebaseFirestore)),
            ChangeNotifierProvider(create: (context) => UserProvider()),
            ChangeNotifierProvider(create: (context)=>mockRecipePostsProvider)
          ],
          child: MaterialApp(
            home: Material(
              child: CreatePostPage(),
            ),
          ),
        )
    );
    final buttonFinder = find.byKey(ValueKey('SavePost'));
    final descriptionFinder = find.byKey(ValueKey("Description"));
    final titleFinder = find.byKey(ValueKey("Title"));
    final postTypeFinder = find.byKey(ValueKey("Type"));

    expect(buttonFinder, findsOneWidget);
    expect(descriptionFinder, findsOneWidget);
    expect(titleFinder, findsOneWidget);
    expect(postTypeFinder, findsOneWidget);

    await tester.tap(postTypeFinder);
    await tester.pump();
    await tester.pump(Duration(seconds: 1));
    await tester.tap(find.text('Recipe Post').last);

    await tester.enterText(titleFinder, "Lavender Boba");
    await tester.enterText(descriptionFinder, "First Recipe.");
    await tester.dragUntilVisible(
      buttonFinder, // what you want to find
      find.byType(SingleChildScrollView), // widget you want to scroll
      const Offset(0, 50), // delta to move
    );
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    final snapshot = await fakeFirebaseFirestore.collection('recipies').get();
    expect(snapshot.docs.length, 1);
    expect(snapshot.docs.first.get('description'), isNotNull);
    expect(snapshot.docs.first.get('recipeTitle'), isNotNull);

    final snackBarFinder = find.byKey(ValueKey("SnackBar"));
    expect(snackBarFinder, findsOneWidget);
    expect(find.textContaining('successfully'), findsOneWidget);

    await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CommentProvider(fakeFirebaseFirestore)),
            ChangeNotifierProvider(create: (context)=>mockRecipePostsProvider)
          ],
          child: MaterialApp(
            home: Material(
              child: RecipePostCard(post: recipePost),
            ),
          ),
        )
    );
    await tester.pump();
    expect(find.textContaining('Lavender'), findsOneWidget);
    expect(find.textContaining('First'), findsOneWidget);
  });

  testWidgets('Testing erros on create post', (tester) async {
    RecipePostsProvider mockRecipePostsProvider = MockRecipePostsProvider();
    final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();

    List<RecipePost> recipeEvents = [
      RecipePost(
          recipeTitle: "Lavender Boba",
          userName: "Admin",
          description: "First Recipe",
          imageRef: 'assets/spaceneedle.jpg')
    ];

    when(
        mockRecipePostsProvider.recipePosts
    ).thenAnswer((_) => recipeEvents);


    await tester.pumpWidget(
      MultiProvider(
          providers: [
            Provider(create: (context)=>CommunityDatabase(fakeFirebaseFirestore)),
            Provider(create: (context)=>RecipeDatabase(fakeFirebaseFirestore)),
            ChangeNotifierProvider(create: (context)=>mockRecipePostsProvider)
          ],
        child: MaterialApp(
          home: Material(
            child: CreatePostPage(),
          ),
        ),
      )
    );
    final buttonFinder = find.byKey(ValueKey('SavePost'));

    expect(buttonFinder, findsOneWidget);
    await tester.dragUntilVisible(
      buttonFinder, // what you want to find
      find.byType(SingleChildScrollView), // widget you want to scroll
      const Offset(0, 50), // delta to move
    );
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.textContaining('Please enter a title'), findsOneWidget);
    expect(find.textContaining('Please enter the description'), findsOneWidget);
  });
}